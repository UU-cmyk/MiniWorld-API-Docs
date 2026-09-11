--- @class Buff
--- 状态模块管理接口 Buff
local Buff = {}
_G.Buff = Buff

--- 给对象附加效果
--- @param objId number @对象ID
--- @param buffId number @效果ID
--- @param customticks? number @效果持续时间 **(-1表示默认配置，0表示无限)**
--- @return boolean @成功返回true，失败返回false
function Buff:addBuff(objId, buffId, customticks) return true end

--- 给对象移除指定效果
--- @param objId number @对象ID
--- @param buffId number @效果ID
--- @return boolean @成功返回true，失败返回false
function Buff:removeBuff(objId, buffId) return true end

--- 给对象清除所有效果
--- @param objId number @对象ID
--- @return boolean @成功返回true，失败返回false
function Buff:clearAllBuff(objId) return true end

--- 为对象清除所有负面效果
--- @param objId number @对象ID
--- @return boolean @成功返回true，失败返回false
function Buff:clearAllBadBuff(objId) return true end

--- 判断对象身上是否有指定效果
--- @param objId number @对象ID
--- @param buffId number @效果ID
--- @param bufflv number @效果等级
--- @return boolean @成功返回true，失败返回false
function Buff:hasBuff(objId, buffId, bufflv) return true end

--- 获取对象身上效果列表
--- @param objId number @对象ID
--- @return number, table @效果数量, 效果ID数组
function Buff:getBuffList(objId) return 0, {} end

--- 获取对象身上指定效果数量
--- @param objId number @对象ID
--- @param buffId number @效果ID
--- @return number @数量
function Buff:getBuffNumByBuffid(objId, buffId) return 0 end

--- 获取对象身上指定效果剩余时间
--- @param objId number @对象ID
--- @param buffId number @效果ID
--- @return number @剩余时间 **(秒，0表示永久)**
function Buff:getBuffLeftTime(objId, buffId) return 0 end

--- 获取状态效果名称
--- @param buffId number @效果ID
--- @return string @效果名称
function Buff:GetBuffDefName(buffId) return "" end

--- 获取状态效果描述
--- @param buffId number @效果ID
--- @return string @状态效果描述
function Buff:GetBuffDefDesc(buffId) return "" end

--- 获取对象身上状态效果名称
--- @param objId number @对象ID
--- @param buffId number @效果ID
--- @return number, string @状态码, 效果名称
function Buff:getBuffName(objId, buffId) return 0, "" end

--- 获取对象身上指定效果的索引位置 (从1开始)
--- @param objId number @对象ID
--- @param buffId number @效果ID
--- @return number, number @状态码, 索引位置
function Buff:getBuffIndex(objId, buffId) return 0, 0 end