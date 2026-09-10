--- @class CloudSever
--- 云服数据存储接口 CloudSever
local CloudSever = {}
_G.CloudSever = CloudSever

--- 设置排行榜中指定键的数值
--- @param libvarname string @排行榜变量设计名
--- @param key string @获取的键值
--- @param value number @设置的数值
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:setOrderDataBykey(libvarname, key, value) return 0 end

--- 删除排行榜中指定键的数值
--- @param libvarname string @排行榜变量设计名
--- @param key string @获取的键值
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:removeOrderDataByKey(libvarname, key) return 0 end

--- 获取排行榜中指定键的数值
--- @param libvarname string @排行榜变量设计名
--- @param key string @获取的键值
--- @param callback function @更新回调(function(code/错误码 ...) 0成功 1失败 2数据不存在)
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:getOrderDataByKeyEx(libvarname, key, callback) return 0 end

--- 获取排行榜中指定排名的数值
--- @param libvarname string @排行榜变量设计名
--- @param index number @获取数据的名次
--- @param callback function @更新回调(function(code/错误码 ...) 0成功 1失败 2数据不存在)
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:getOrderDataIndexValueEx(libvarname, index, callback) return 0 end

--- 清理排行榜
--- @param libvarname string @排行榜变量设计名
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:ClearOrderData(libvarname) return 0 end

--- 变量自运算
--- @param libvarname string @排行榜变量设计名
--- @param key string @获取的键值
--- @param value number @每次加的值
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:automaticByKey(libvarname, key, value) return 0 end

--- 获取排行榜中多条数据
--- @param libvarname string @排行榜变量设计名
--- @param icount number @获取数据的条数
--- @param callback function @更新回调(function(code/错误码 ...) 0成功 1失败 2数据不存在)
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:getOrderDataIndexAreaEx(libvarname, icount, callback) return 0 end

--- 获取排行榜中指定值区域的前多少名数据
--- @param libvarname string @排行榜变量设计名
--- @param icount number @获取数据的条数
--- @param minvalue number @最小值
--- @param maxvalue number @最大值
--- @param callback function @更新回调(function(code/错误码 ...) 0成功 1失败)
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:getOrderDataValueAreaEx(libvarname, icount, minvalue, maxvalue, callback) return 0 end

--- 设置表中指定键的值
--- @param libvarname string @表变量设计名
--- @param key string @获取的键值
--- @param value any @任意值(number, string, table)
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:setDataListBykey(libvarname, key, value) return 0 end

--- 删除表中指定键的值
--- @param libvarname string @表变量设计名
--- @param key string @获取的键值
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:removeDataListByKey(libvarname, key) return 0 end

--- 获取表中指定键的值
--- @param libvarname string @表变量设计名
--- @param key string @获取的键值
--- @param callback function @更新回调(function(code/错误码 ...) 0成功 1失败 2数据不存在)
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:getDataListByKeyEx(libvarname, key, callback) return 0 end

--- 清空表数据
--- @param libvarname string @表变量设计名
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:ClearDataList(libvarname) return 0 end

--- 获取表或排行榜当前缓存数据
--- @param libvarname string @表变量设计名
--- @return number, any @成功返回 ErrorCode.OK 和当前缓存数据
function CloudSever:getlistCache(libvarname) return 0, nil end

--- 安全更新数据
--- @param libvarname string @表变量设计名
--- @param key string @更新的键值
--- @param callback function @更新回调(function(code/错误码 ...))
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:UpdateDataListByKey(libvarname, key, callback) return 0 end

--- 发送服务通知消息
--- @param msg string @消息名称
--- @param customdata any @消息附带参数
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:SendSeverMsg(msg, customdata) return 0 end

--- 传送玩家到指定地图
--- @param playerid number|table @玩家UIN或玩家UIN数组
--- @param mapid number @地图ID
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:TransmitToMap(playerid, mapid) return 0 end

--- 传送玩家到指定房间
--- @param playerid number|table @玩家UIN或玩家UIN数组
--- @param roomid string @房间ID
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:TransmitToRoom(playerid, roomid) return 0 end

--- 传送玩家到其他房间
--- @param playerid number|table @玩家UIN或玩家UIN数组
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:TransmitOtherRoom(playerid) return 0 end

--- 获取当前云服房间ID
--- @return number, string @成功返回 ErrorCode.OK 和房间ID
function CloudSever:GetRoomID() return 0, "" end

--- 传送玩家到指定分类房间
--- @param playerid number|table @玩家UIN或玩家UIN数组
--- @param roomtype string @分类ID(数值和字符串组合)
--- @param mapid string @地图ID
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:TransmitToCategoryRoom(playerid, roomtype, mapid) return 0 end

--- 当前房间停止进入玩家（仅云服生效）
--- @param seconds number @倒计时事件（小于等于零立即生效，默认0）
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:SetForbidJoin(seconds) return 0 end

--- 关闭当前房间（仅云服生效）
--- @param countdown number @倒计时事件（小于等于零立即生效，默认0）
--- @param msg string @提示语
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function CloudSever:CloseCurRoom(countdown, msg) return 0 end

--- 获取当前房间的分类信息（仅云服生效）
--- @return number, string @成功返回 ErrorCode.OK 和分类信息
function CloudSever:GetRoomCategory() return 0, "" end
