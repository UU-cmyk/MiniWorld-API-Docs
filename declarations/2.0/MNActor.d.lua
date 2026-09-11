--- @class Actor
--- 角色模块管理接口 Actor
local Actor = {}
_G.Actor = Actor

--- 检测是否为玩家
--- @param objId number @对象ID
--- @return number @成功返回 ErrorCode.OK
function Actor:isPlayer(objId) return 0 end

--- 检测是否为怪物
--- @param objId number @对象ID
--- @return number @成功返回 ErrorCode.OK
function Actor:isMob(objId) return 0 end

--- 获取对象类型
--- @param objId number @对象ID
--- @return number, number @成功返回 ErrorCode.OK 和对象类型
function Actor:getObjType(objId) return 0, 0 end

--- 是否在空中
--- @param objId number @对象ID
--- @return number @成功返回 ErrorCode.OK
function Actor:isInAir(objId) return 0 end

--- 获取actor位置
--- @param objId number @对象ID
--- @return number, number, number, number @成功返回 ErrorCode.OK 和 x,y,z 坐标
function Actor:getPosition(objId) return 0, 0, 0, 0 end

--- 设置actor位置
--- @param objId number @对象ID
--- @param x number @目标X坐标
--- @param y number @目标Y坐标
--- @param z number @目标Z坐标
--- @return number @成功返回 ErrorCode.OK
function Actor:setPosition(objId, x, y, z) return 0 end

--- 跳跃
--- @param objId number @对象ID
--- @return number @成功返回 ErrorCode.OK
function Actor:jump(objId) return 0 end

--- 击败对象
--- @param objId number @对象ID
--- @return number @成功返回 ErrorCode.OK
function Actor:killSelf(objId) return 0 end

--- 获取当前朝向
--- @param objId number @对象ID
--- @return number, number @成功返回 ErrorCode.OK 和朝向值
function Actor:getCurPlaceDir(objId) return 0, 0 end

--- 向目标行动者移动
--- @param self_objId number @执行动作的对象ID
--- @param target_objId number @目标对象ID
--- @param speed number @移动速度
--- @return number @成功返回 ErrorCode.OK
function Actor:tryMoveToActor(self_objId, target_objId, speed) return 0 end

--- 向目标位置移动
--- @param objId number @对象ID
--- @param x number @目标X坐标
--- @param y number @目标Y坐标
--- @param z number @目标Z坐标
--- @param speed number @移动速度
--- @return number @成功返回 ErrorCode.OK
function Actor:tryMoveToPos(objId, x, y, z, speed) return 0 end

--- 增加当前生命量
--- @param objId number @对象ID
--- @param hp number @血量值
--- @return number @成功返回 ErrorCode.OK
function Actor:addHP(objId, hp) return 0 end

--- 获取当前生命量
--- @param objId number @对象ID
--- @return number, number @成功返回 ErrorCode.OK 和生命值
function Actor:getHP(objId) return 0, 0 end

--- 获取最大生命量
--- @param objId number @对象ID
--- @return number, number @成功返回 ErrorCode.OK 和最大生命值
function Actor:getMaxHP(objId) return 0, 0 end

--- 增加当前氧气值
--- @param objId number @对象ID
--- @param oxygen number @氧气值
--- @return number @成功返回 ErrorCode.OK
function Actor:addOxygen(objId, oxygen) return 0 end

--- 获取当前氧气值
--- @param objId number @对象ID
--- @return number, number @成功返回 ErrorCode.OK 和氧气值
function Actor:getOxygen(objId) return 0, 0 end

--- 增加装备附魔
--- @param objId number @对象ID
--- @param slot number @装备栏ID
--- @param enchantId number @附魔ID
--- @param enchantLevel number @附魔等级
--- @return number @成功返回 ErrorCode.OK
function Actor:addEnchant(objId, slot, enchantId, enchantLevel) return 0 end

--- 移除装备附魔
--- @param objId number @对象ID
--- @param slot number @装备栏ID
--- @param enchantId number @附魔ID
--- @return number @成功返回 ErrorCode.OK
function Actor:removeEnchant(objId, slot, enchantId) return 0 end

--- 寻找附近方块
--- @param objId number @对象ID
--- @param blockId number @方块ID
--- @param blockRange number @搜索范围
--- @return number, number, number, number @成功返回 ErrorCode.OK & x,y,z 坐标
function Actor:findNearestBlock(objId, blockId, blockRange) return 0, 0, 0, 0 end

--- 设置actor原地旋转偏移角度
--- @param objId number @对象ID
--- @param yaw number @偏移角度
--- @return number @成功返回 ErrorCode.OK
function Actor:setFaceYaw(objId, yaw) return 0 end

--- 获取actor原地旋转偏移角度
--- @param objId number @对象ID
--- @return number, number @成功返回 ErrorCode.OK 和偏移角度
function Actor:getFaceYaw(objId) return 0, 0 end

--- 转动actor横向偏移角度
--- @param objId number @对象ID
--- @param offset number @转动角度
--- @return number @成功返回 ErrorCode.OK
function Actor:turnFaceYaw(objId, offset) return 0 end

--- 设置actor视角仰望角度
--- @param objId number @对象ID
--- @param pitch number @仰望角度
--- @return number @成功返回 ErrorCode.OK
function Actor:setFacePitch(objId, pitch) return 0 end

--- 获取actor视角仰望角度
--- @param objId number @对象ID
--- @return number, number @成功返回 ErrorCode.OK 和仰望角度
function Actor:getFacePitch(objId) return 0, 0 end

--- 转动actor仰望偏移角度
--- @param objId number @对象ID
--- @param offset number @转动角度
--- @return number @成功返回 ErrorCode.OK
function Actor:turnFacePitch(objId, offset) return 0 end

--- 对象播放特效
--- @param objId number @对象ID
--- @param type number @特效类型
--- @return number @成功返回 ErrorCode.OK
function Actor:playBodyEffect(objId, type) return 0 end

--- 对象停止特效
--- @param objId number @对象ID
--- @param type number @特效类型
--- @return number @成功返回 ErrorCode.OK
function Actor:stopBodyEffect(objId, type) return 0 end

--- 播放文件特效
--- @param objId number @对象ID
--- @param filename string @文件名
--- @param sync boolean @同步
--- @return number @成功返回 ErrorCode.OK
function Actor:playBodyEffectByFile(objId, filename, sync) return 0 end

--- 停止文件特效
--- @param objId number @对象ID
--- @param filename string @文件名
--- @return number @成功返回 ErrorCode.OK
function Actor:stopBodyEffectByFile(objId, filename) return 0 end

--- 播放声音
--- @param objId number @对象ID
--- @param name string @声音名称
--- @param volume number @音量
--- @param pitch number @音调
--- @param flag number @参数
--- @return number @成功返回 ErrorCode.OK
function Actor:playSound(objId, name, volume, pitch, flag) return 0 end

--- 播放声音(特定类型)
--- @param objId number @对象ID
--- @param name string @声音名称
--- @param type number @指定类型
--- @return number @成功返回 ErrorCode.OK
function Actor:playSoundSpecial(objId, name, type) return 0 end

--- 清除生物ID为actorid的生物
--- @param actorid number @生物ID
--- @param bkill boolean @是否显示死亡效果
--- @return number @成功返回 ErrorCode.OK
function Actor:clearActorWithId(actorid, bkill) return 0 end

--- 设置伤害类型
--- @param objId number @对象ID
--- @param attacktype number @伤害类型
--- @return number @成功返回 ErrorCode.OK
function Actor:setAttackType(objId, attacktype) return 0 end

--- 设置免疫伤害类型
--- @param objId number @对象ID
--- @param immunetype number @伤害类型
--- @param isadd boolean @是否开启
--- @return number @成功返回 ErrorCode.OK
function Actor:setImmuneType(objId, immunetype, isadd) return 0 end

--- 登上、脱离载具
--- @param objId number @对象ID
--- @param mountobjId number @被骑乘对象ID
--- @param posindex number @骑乘位
--- @return number @成功返回 ErrorCode.OK
function Actor:mountActor(objId, mountobjId, posindex) return 0 end

--- 设置生物行为属性状态
--- @param objId number @对象ID
--- @param actionattr number @属性类型
--- @param switch boolean @是否开启
--- @return number @成功返回 ErrorCode.OK
function Actor:setActionAttrState(objId, actionattr, switch) return 0 end

--- 获取生物特殊属性的状态
--- @param objId number @对象ID
--- @param actionattr number @属性类型
--- @return number, boolean @成功返回 ErrorCode.OK 和状态
function Actor:getActionAttrState(objId, actionattr) return 0, false end

--- 寻路到目标位置
--- @param objId number @对象ID
--- @param x number @目标X坐标
--- @param y number @目标Y坐标
--- @param z number @目标Z坐标
--- @param cancontrol boolean @是否可控制
--- @param showtip boolean @是否显示路线提示
--- @return number @成功返回 ErrorCode.OK
function Actor:tryNavigationToPos(objId, x, y, z, cancontrol, showtip) return 0 end

--- 在资源库里随机创建一个生物
--- @return number, number @成功返回 ErrorCode.OK 和生物ID
function Actor:randomActorID() return 0, 0 end

--- 获取骑乘生物的objid
--- @param objId number @对象ID
--- @return number, number @成功返回 ErrorCode.OK 和骑乘对象ID
function Actor:getRidingActorObjId(objId) return 0, 0 end

--- 在指定对象身上播放粒子特效
--- @param objId number @对象ID
--- @param particleId number @特效ID
--- @param scale number @特效大小
--- @param ptme number @时长(秒)
--- @return number @成功返回 ErrorCode.OK
function Actor:playBodyEffectById(objId, particleId, scale, ptme) return 0 end

--- 停止指定对象身上的粒子特效
--- @param objId number @对象ID
--- @param particleId number @特效ID
--- @return number @成功返回 ErrorCode.OK
function Actor:stopBodyEffectById(objId, particleId) return 0 end

--- 设置指定对象身上的特效大小
--- @param objId number @对象ID
--- @param particleId number @特效ID
--- @param scale number @特效大小
--- @return number @成功返回 ErrorCode.OK
function Actor:setBodyEffectScale(objId, particleId, scale) return 0 end

--- 在指定对象身上播放音效
--- @param objId number @对象ID
--- @param soundId number @音效ID
--- @param volume number @音量
--- @param pitch number @音调
--- @param isLoop boolean @是否循环播放
--- @return number @成功返回 ErrorCode.OK
function Actor:playSoundEffectById(objId, soundId, volume, pitch, isLoop) return 0 end

--- 停止指定对象身上的音效
--- @param objId number @对象ID
--- @param soundId number @音效ID
--- @return number @成功返回 ErrorCode.OK
function Actor:stopSoundEffectById(objId, soundId) return 0 end

--- 给对象附加一个速度
--- @param objId number @对象ID
--- @param x number @X方向速度
--- @param y number @Y方向速度
--- @param z number @Z方向速度
--- @return number @成功返回 ErrorCode.OK
function Actor:appendSpeed(objId, x, y, z) return 0 end

--- 获取actor朝向
--- @param objId number @对象ID
--- @return number, number, number, number @成功返回 ErrorCode.OK 和方向值
function Actor:getFaceDirection(objId) return 0, 0, 0, 0 end

--- 通过局部坐标方向计算绝对方向
--- @param objId number @对象ID
--- @param vx number @局部X方向
--- @param vy number @局部Y方向
--- @param vz number @局部Z方向
--- @return number, table @成功返回 ErrorCode.OK 和方向表
function Actor:calcDirectionByDirection(objId, vx, vy, vz) return 0, {} end

--- 通过局部球坐标方向计算绝对方向
--- @param objId number @对象ID
--- @param yaw number @局部水平偏移
--- @param pitch number @局部垂直偏移
--- @return number, table @成功返回 ErrorCode.OK 和方向表
function Actor:calcDirectionByAngle(objId, yaw, pitch) return 0, {} end

--- 通过局部坐标方向计算绝对正方向
--- @param objId number @对象ID
--- @param vx number @局部X方向
--- @param vy number @局部Y方向
--- @param vz number @局部Z方向
--- @return number, table @成功返回 ErrorCode.OK 和方向表
function Actor:calcDirectionByYawDirection(objId, vx, vy, vz) return 0, {} end

--- 通过局部球坐标方向计算绝对正方向
--- @param objId number @对象ID
--- @param yaw number @局部水平偏移
--- @param pitch number @局部垂直偏移
--- @return number, table @成功返回 ErrorCode.OK 和方向表
function Actor:calcDirectionByYawAngle(objId, yaw, pitch) return 0, {} end

--- 获取眼睛高度
--- @param objId number @对象ID
--- @return number, number @成功返回 ErrorCode.OK 和高度
function Actor:getEyeHeight(objId) return 0, 0 end

--- 获取眼睛位置
--- @param objId number @对象ID
--- @return number, number, number, number @成功返回 ErrorCode.OK 和 x,y,z 坐标
function Actor:getEyePosition(objId) return 0, 0, 0, 0 end

--- 获取身体尺寸
--- @param objId number @对象ID
--- @return number, number, number @成功返回 ErrorCode.OK 和宽、高
function Actor:getBodySize(objId) return 0, 0, 0 end

--- 播放动作
--- @param objId number @对象ID
--- @param actid number @动作ID
--- @return number @成功返回 ErrorCode.OK
function Actor:playAct(objId, actid) return 0 end

--- 设置昵称显示
--- @param objId number @对象ID
--- @param bshow boolean @是否显示
--- @return number @成功返回 ErrorCode.OK
function Actor:shownickname(objId, bshow) return 0 end

--- 设置昵称
--- @param objId number @对象ID
--- @param nickname string @名称
--- @return number @成功返回 ErrorCode.OK
function Actor:setnickname(objId, nickname) return 0 end

--- 获取Actor的外观
--- @param objId number @对象ID
--- @return number, string @成功返回 ErrorCode.OK 和外观名称
function Actor:getActorFacade(objId) return 0, "" end

--- 改变Actor外观
--- @param objId number @对象ID
--- @param modelName string @外观名称
--- @return number @成功返回 ErrorCode.OK
function Actor:changeCustomModel(objId, modelName) return 0 end

--- 恢复生物外观
--- @param objId number @对象ID
--- @return number @成功返回 ErrorCode.OK
function Actor:recoverinitialModel(objId) return 0 end

--- 增加指定BUFF
--- @param objId number @对象ID
--- @param buffid number @BUFF ID
--- @param bufflv number @BUFF 等级
--- @param customticks number @持续时间
--- @return number @成功返回 ErrorCode.OK
function Actor:addBuff(objId, buffid, bufflv, customticks) return 0 end

--- 是否已经有了指定BUFF
--- @param objId number @对象ID
--- @param buffid number @BUFF ID
--- @return number, boolean @成功返回 ErrorCode.OK 和布尔值
function Actor:hasBuff(objId, buffid) return 0, false end

--- 移除指定BUFF
--- @param objId number @对象ID
--- @param buffid number @BUFF ID
--- @return number @成功返回 ErrorCode.OK
function Actor:removeBuff(objId, buffid) return 0 end

--- 清除全部BUFF
--- @param objId number @对象ID
--- @return number @成功返回 ErrorCode.OK
function Actor:clearAllBuff(objId) return 0 end

--- 清除全部减益BUFF
--- @param objId number @对象ID
--- @return number @成功返回 ErrorCode.OK
function Actor:clearAllBadBuff(objId) return 0 end

--- 获取已有BUFF
--- @param objId number @对象ID
--- @return number, number, table @成功返回 ErrorCode.OK、BUFF 数量、BUFF ID 数组
function Actor:getBuffList(objId) return 0, 0, {} end

--- 获取BUFF剩余tick
--- @param objId number @对象ID
--- @param buffid number @BUFF ID
--- @return number, number @成功返回 ErrorCode.OK 和剩余 tick
function Actor:getBuffLeftTick(objId, buffid) return 0, 0 end

--- 获取随机外观id字符串
--- @return number, string @成功返回 ErrorCode.OK 和外观ID
function Actor:randomFacadeID() return 0, "" end

--- 使玩家对生物或玩家造成伤害
--- @param objIdA number @攻击者对象ID
--- @param objIdB number @被攻击者对象ID
--- @param hp number @伤害数值
--- @param attackType number @伤害类型
--- @return number @成功返回 ErrorCode.OK
function Actor:playerHurt(objIdA, objIdB, hp, attackType) return 0 end

--- 使玩家伤害区域内的目标
--- @param objIdA number @攻击者对象ID
--- @param areaid number @区域ID
--- @param hp number @伤害数值
--- @param attackType number @伤害类型
--- @return number @成功返回 ErrorCode.OK
function Actor:playerHurtArea(objIdA, areaid, hp, attackType) return 0 end

--- 使生物对生物或玩家造成伤害
--- @param objIdA number @攻击者对象ID
--- @param objIdB number @被攻击者对象ID
--- @param hp number @伤害数值
--- @param attackType number @伤害类型
--- @return number @成功返回 ErrorCode.OK
function Actor:actorHurt(objIdA, objIdB, hp, attackType) return 0 end

--- 使生物伤害区域内的目标
--- @param objIdA number @攻击者对象ID
--- @param areaid number @区域ID
--- @param hp number @伤害数值
--- @param attackType number @伤害类型
--- @return number @成功返回 ErrorCode.OK
function Actor:actorHurtArea(objIdA, areaid, hp, attackType) return 0 end

--- 获取actor位置
--- @param objId number @对象ID
--- @return number, table @成功返回 ErrorCode.OK 和坐标表
function Actor:getPositionV2(objId) return 0, {} end

--- 设置对象朝向
--- @param objId number @对象ID
--- @param x number @X方向
--- @param y number @Y方向
--- @param z number @Z方向
--- @return number @成功返回 ErrorCode.OK
function Actor:setFaceDirection(objId, x, y, z) return 0 end

--- 改变对象为指定玩家ID的皮肤外观
--- @param objId number @对象ID
--- @param uin number @玩家Uin
--- @return number @成功返回 ErrorCode.OK
function Actor:ChangePlayerSkin(objId, uin) return 0 end
