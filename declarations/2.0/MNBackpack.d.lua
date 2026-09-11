--- @class Backpack
--- 背包模块管理接口 Backpack
local Backpack = {}
_G.Backpack = Backpack

--- 获取道具背包栏ID范围 (起始ID~结束ID)
--- @param barType number @背包类型枚举 (1快捷栏 2储存栏 3装备栏)
--- @return number, number, number @状态码, 起始ID, 结束ID
function Backpack:getBackpackBarIDRange(barType) return 0, 0, 0 end

--- 获取道具背包栏大小
--- @param barType number @背包类型枚举 (1快捷栏 2储存栏 3装备栏)
--- @return number, number @状态码, 背包栏大小
function Backpack:getBackpackBarSize(barType) return 0, 0 end

--- 设置背包格道具
--- @param playerId number @玩家ID
--- @param gridid number @格子ID
--- @param itemId number @道具类型
--- @param num number @道具数量(默认1)
--- @return boolean @是否成功
function Backpack:setGridItem(playerId, gridid, itemId, num) return true end

--- 移除背包格内一定数量道具
--- @param playerId number @玩家ID
--- @param gridid number @格子ID
--- @param num number @道具数量(默认全部移除)
--- @return boolean @是否成功
function Backpack:removeGridItem(playerId, gridid, num) return true end

--- 移除背包内一定数量道具,通过道具ID移除,默认全部移除
--- @param playerId number @玩家ID
--- @param itemId number @道具类型
--- @param num number @道具数量
--- @return number @移除数量(ret and ret>0 成功)
function Backpack:removeGridItemByItemID(playerId, itemId, num) return 0 end

--- 清空指定背包栏
--- @param playerId number @玩家ID
--- @param bartype number @背包栏类型
--- @return boolean @是否成功
function Backpack:clearPack(playerId, bartype) return true end

--- 清空全部背包(包含背包栏、快捷栏、装备栏)
--- @param playerId number @玩家ID
--- @return boolean @是否成功
function Backpack:clearAllPack(playerId) return true end

--- 移动背包道具,默认全部转移
--- @param playerId number @玩家ID
--- @param gridsrc number @源格子ID
--- @param griddst number @移动至的目标格子ID
--- @param num number @道具数量(默认全部)
--- @return boolean @是否成功
function Backpack:moveGridItem(playerId, gridsrc, griddst, num) return true end

--- 交换背包道具
--- @param playerId number @玩家ID
--- @param grid1 number @格子1 ID
--- @param grid2 number @格子2 ID
--- @return boolean @是否成功
function Backpack:swapGridItem(playerId, grid1, grid2) return true end

--- 背包(包含背包栏、快捷栏)是否有足够的空间存放一定数量的道具
--- @param playerId number @玩家ID
--- @param itemId number @道具类型
--- @param num number @道具数量(默认1)
--- @return boolean @是否成功
function Backpack:enoughSpaceForItem(playerId, itemId, num) return true end

--- 计算背包(包含背包栏、快捷栏)能存放的道具剩余总数量
--- @param playerId number @玩家ID
--- @param itemId number @道具类型
--- @return number @可以存放的数量
function Backpack:calcSpaceNumForItem(playerId, itemId) return 0 end

--- 获取道具背包栏有效格ID列表(道具已存在)，背包格ID数组
--- @param playerId number @玩家ID
--- @param barType number @背包栏类型
--- @return number, number, number @状态码, 数量, 背包格ID数组
function Backpack:getBackpackBarValidList(playerId, barType) return 0, 0, 0 end

--- 获取道具背包栏已拥有道具，道具ID数组
--- @param playerId number @玩家ID
--- @param barType number @背包栏类型
--- @return number, number, number @状态码, 数量, 背包格ID数组
function Backpack:getBackpackBarItemList(playerId, barType) return 0, 0, 0 end

--- 检测背包是否持有某个道具
--- @param playerId number @玩家ID
--- @param bartype number @背包栏类型
--- @param itemId number @道具类型
--- @return boolean @是否成功
function Backpack:hasItemByBackpackBar(playerId, bartype, itemId) return true end

--- 获取背包持有某个道具总数量,同时返回装有道具的背包格数组
--- @param playerId number @玩家ID
--- @param bartype number @背包栏类型
--- @param itemId number @道具类型
--- @return number,table @道具数量,格子ID数组
function Backpack:getItemNumByBackpackBar(playerId, bartype, itemId) return 0, {} end

--- 获取背包格道具ID(返回itemId, num)
--- @param playerId number @玩家ID
--- @param gridid number @格子ID
--- @return number,number @道具类型,道具数量(无道具 数量是0 itemid是0)
function Backpack:getGridItemID(playerId, gridid) return 0, 0 end

--- 获取背包格道具名称
--- @param playerId number @玩家ID
--- @param gridid number @格子ID
--- @return string @道具名称
function Backpack:getGridItemName(playerId, gridid) return "" end

--- 添加道具到背包
--- @param playerId number @玩家ID
--- @param itemId number @道具类型
--- @param num number @道具数量
--- @param priorityType number @优先快捷栏还是背包栏:1优先快捷栏 2优先背包栏(默认1)
--- @return number @成功添加的数量
function Backpack:addItem(playerId, itemId, num, priorityType) return 0 end

--- 丢弃背包某个格子里的道具
--- @param playerId number @玩家ID
--- @param gridid number @格子ID
--- @param num number @道具数量
--- @param ablePick boolean @能否拾取
--- @return boolean @是否成功
function Backpack:discardItem(playerId, gridid, num, ablePick) return true end

--- 玩家穿上装备
--- @param playerId number @玩家ID
--- @param itemId number @道具类型
--- @param frompos number @格子ID (可不传, 如果不为`nil` 则必须和`itemId`一致)
--- @return boolean @是否成功
function Backpack:actEquipUpByResID(playerId, itemId, frompos) return true end

--- 玩家脱下装备栏装备
--- @param playerId number @玩家ID
--- @param grid number @装备栏ID
--- @param grid2 number @目标格子ID (可不传,如果不为`nil` 则必须是空格子)
--- @return boolean @是否成功
function Backpack:actEquipOffByEquipID(playerId, grid, grid2) return true end

--- 销毁装备
--- @param playerId number @玩家ID
--- @param grid number @装备栏ID
--- @return boolean @是否成功
function Backpack:actDestructEquip(playerId, grid) return true end

--- 设置快捷栏指定道具上播放特效
--- @param objid number @玩家ID
--- @param itemId number @道具类型
--- @param effectId number @特效ID
--- @param scale number @特效缩放
--- @return number @状态码
function Backpack:PlayShortCutItemEffect(objid, itemId, effectId, scale) return 0 end

--- 设置手持栏道具上播放特效
--- @param objid number @玩家ID
--- @param effectId number @特效ID
--- @param scale number @特效缩放
--- @return number @状态码
function Backpack:PlayShortCutIxEffect(objid, effectId, scale) return 0 end

--- 停止快捷栏指定道具上播放特效
--- @param objid number @玩家ID
--- @param itemId number @道具类型
--- @param effectId number @特效ID
--- @return number @状态码
function Backpack:StopShortCutItemEffect(objid, itemId, effectId) return 0 end

--- 停止手持栏道具上播放特效
--- @param objid number @玩家ID
--- @param effectId number @特效ID
--- @return number @状态码
function Backpack:StopShortCutIxEffect(objid, effectId) return 0 end

--- 创建装备
--- @param objid number @玩家ID
--- @param resId number @装备ID
--- @return number @状态码
function Backpack:actCreateEquip(objid, resId) return 0 end

--- 获取背包格道具耐久度 (返回`durcur`, `durmax`)
--- 
--- `0`为储存栏的第1格，`0`-`29`储存栏，`1000`-`1007`快捷栏，`8000`-`8004`装备栏
--- @param playerId number @玩家ID
--- @param gridId number @格子ID
--- @return number, number, number @状态码, 当前耐久度, 最大耐久度
function Backpack:getGridDurability(playerId, gridId) return 0, 0, 0 end

--- 获取背包格道具附魔，返回附魔ID数组
--- @param playerId number @玩家ID
--- @param gridId number @格子ID
--- @return number, number, table @状态码, 附魔数量, 附魔ID数组
function Backpack:getGridEnchantList(playerId, gridId) return 0, 0, {} end

--- 获取背包某个格子的道具数量
--- @param playerId number @玩家ID
--- @param gridId number @格子ID
--- @return number, number @状态码, 道具数量
function Backpack:getGridNum(playerId, gridId) return 0, 0 end

--- 获取背包格道具堆叠数 (返回`curstack`, `maxstack`)
--- @param playerId number @玩家ID
--- @param gridId number @格子ID
--- @return number, number, number @状态码, 当前堆叠数, 最大堆叠数
function Backpack:getGridStack(playerId, gridId) return 0, 0, 0 end

--- 获取背包道具工具类型
--- 
--- 返回值: `-1`非道具 / `1`斧 / `2`镐 / `3`铲 / `4`锄 / `6`剑 / `7`弓 / `14`投掷
--- @param playerId number @玩家ID
--- @param gridId number @格子ID
--- @return number, number @状态码, 工具类型
function Backpack:getGridToolType(playerId, gridId) return 0, 0 end