# DNSQLiteDemo
本地化存储之SQLite.swift使用

第三方库[SQLite.swift](https://github.com/stephencelis/SQLite.swift)

### 创建数据库文件
```
mutating func createdsqlite3() {
        // 设置数据库路径
        let sqlFilePath = NSHomeDirectory() + "/Documents/usersinfodb.sqlite3"
        do {
            db = try Connection(sqlFilePath)
            try db.run(users.create(block: { (table) in
                table.column(id, primaryKey: true)
                table.column(username)
                table.column(userage)
                table.column(usersex)
                table.column(userid)
                table.column(useremail)
            }))
        } catch {
            print("创建数据库出错: \(error)")
        }
    }
```
### 添加用户信息
```
func insertUser(userModel: DNUsersModel) {
        // 用户信息中没有ID就不存入数据库(被列为无效用户)
        guard let userId = userModel.userid else {
            print("没有ID信息,视为无效用户")
            return;
        }
        // 查找数据库中是否有该用户,如果有则执行修改操作
        guard readUser(userId: userId) == nil else {
            print("已存在改用户,接下来更新此用户数据")
            updateUser(userId: userId, userModel: userModel)
            return
        }
        let insert = users.insert(username <- userModel.username,
                                  userage <- userModel.userage,
                                  usersex <- userModel.usersex,
                                  userid <- userModel.userid,
                                  useremail <- userModel.useremail)
        
        do {
            let num = try db.run(insert)
            print(num)
        } catch {
            print("增加用户到数据库出错: \(error)")
        }
        
    }
```
### 删除指定用户信息
```
func deleteUser(userId: String) {
        let currUser = users.filter(userid == userId)
        do {
            let num = try db.run(currUser.delete())
            print(num)
        } catch {
            print("删除用户信息出错: \(error)")
        }
    }
```
### 更新指定用户信息
```
func updateUser(userId: String, userModel: DNUsersModel) {
        let currUser = users.filter(userid == userId)
        let update = currUser.update(username <- userModel.username,
                                     userage <- userModel.userage,
                                     usersex <- userModel.usersex,
                                     userid <- userModel.userid,
                                     useremail <- userModel.useremail)
        do {
            let num = try db.run(update)
            print(num)
        } catch {
            print(error)
        }
    }
```
### 更新用户名
```
func updateUser(userId: String, userName: String) {
        let currUser = users.filter(userid == userId)
        let update = currUser.update(username <- userName)
        do {
            let num = try db.run(update)
            print(num)
        } catch {
            print(error)
        }
    }
```
### 查询指定用户信息
```
func readUser(userId: String) -> DNUsersModel? {
        var userModel: DNUsersModel? = DNUsersModel()
        for user in try! db.prepare(users) {
            if user[userid] == userId {
                userModel?.username = user[username]
                userModel?.userage = user[userage]
                userModel?.usersex = user[usersex]
                userModel?.userid = user[userid]
                userModel?.useremail = user[useremail]
                return userModel
            }
        }
        return nil
    }
```
### 查询所有用户信息
```
func readAllUsers() -> [DNUsersModel]? {
        var usersArr: [DNUsersModel]? = [DNUsersModel]()
        var userModel: DNUsersModel? = DNUsersModel()
        for user in try! db.prepare(users) {
            userModel?.username = user[username]
            userModel?.userage = user[userage]
            userModel?.usersex = user[usersex]
            userModel?.userid = user[userid]
            userModel?.useremail = user[useremail]
            usersArr?.append(userModel!)
        }
        return usersArr
    }
```

