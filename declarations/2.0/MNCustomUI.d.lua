--- @class Customui
--- 自定义界面管理接口 Customui
local Customui = {}
_G.Customui = Customui

--- 设置文本元件内容
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param text string @文本内容
--- @param animId? number @动画ID(缺省参数)
--- @param time? number @动画时长(缺省参数)
--- @param mode? number @播放模式(缺省参数)
--- @return number @成功返回 ErrorCode.OK
function Customui:setText(playerId, uiId, elementId, text, animId, time, mode) return 0 end

--- 设置图片元件图案纹理
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param url string @图片ID
--- @return number @成功返回 ErrorCode.OK
function Customui:setTexture(playerId, uiId, elementId, url) return 0 end

--- 设置元件大小
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param width number @元件宽度
--- @param height number @元件高度
--- @return number @成功返回 ErrorCode.OK
function Customui:setSize(playerId, uiId, elementId, width, height) return 0 end

--- 设置文本元件字体大小
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param size number @字体大小
--- @return number @成功返回 ErrorCode.OK
function Customui:setFontSize(playerId, uiId, elementId, size) return 0 end

--- 设置文本元件颜色
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param color string @16进制颜色值
--- @return number @成功返回 ErrorCode.OK
function Customui:setColor(playerId, uiId, elementId, color) return 0 end

--- 显示元件
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param effectid? number @动画ID(缺省参数)
--- @param time? number @动画时长(缺省参数)
--- @return number @成功返回 ErrorCode.OK
function Customui:showElement(playerId, uiId, elementId, effectid, time) return 0 end

--- 隐藏元件
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param effectid? number @动画ID(缺省参数)
--- @param time? number @动画时长(缺省参数)
--- @return number @成功返回 ErrorCode.OK
function Customui:hideElement(playerId, uiId, elementId, effectid, time) return 0 end

--- 旋转元件
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param rotate number @旋转角度(顺时针)
--- @return number @成功返回 ErrorCode.OK
function Customui:rotateElement(playerId, uiId, elementId, rotate) return 0 end

--- 切换页面状态
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param pageIndex string @状态值(页面状态)
--- @param effectid? number @动作枚举(缺省参数)
--- @param time? number @动画时长(缺省参数)
--- @return number @成功返回 ErrorCode.OK
function Customui:setState(playerId, uiId, pageIndex, effectid, time) return 0 end

--- 设置元件透明度
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param alpha number @透明度
--- @return number @成功返回 ErrorCode.OK
function Customui:setAlpha(playerId, uiId, elementId, alpha) return 0 end

--- 设置元件位置
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param x number @X坐标
--- @param y number @Y坐标
--- @return number @成功返回 ErrorCode.OK
function Customui:setPosition(playerId, uiId, elementId, x, y) return 0 end

--- 获取道具类型图标iconID
--- @param itemid number @道具类型ID
--- @return number, number @成功返回 ErrorCode.OK & 道具iconID
function Customui:getItemIcon(itemid) return 0, 0 end

--- 获取生物图标iconID
--- @param objid number @生物ID
--- @return number, number @成功返回 ErrorCode.OK & 生物iconID
function Customui:getMonsterObjIcon(objid) return 0, 0 end

--- 获取生物类型图标iconID
--- @param actorid number @生物类型ID
--- @return number, number @成功返回 ErrorCode.OK & 生物iconID
function Customui:getMonsterIcon(actorid) return 0, 0 end

--- 获取状态类型图标iconID
--- @param buffid number @状态类型ID
--- @return number, number @成功返回 ErrorCode.OK & 状态iconID
function Customui:getStatusIcon(buffid) return 0, 0 end

--- 获取方块类型图标iconID
--- @param blockid number @方块类型ID
--- @return number, number @成功返回 ErrorCode.OK & 方块iconID
function Customui:getBlockIcon(blockid) return 0, 0 end

--- 获取角色类型图标iconID
--- @param playerId number @玩家ID
--- @return number, number @成功返回 ErrorCode.OK & 角色iconID
function Customui:getRoleIcon(playerId) return 0, 0 end

--- 获取玩家快捷栏道具图标iconID
--- @param playerId number @玩家ID
--- @param ix number @快捷栏索引(1~8)
--- @return number, number @成功返回 ErrorCode.OK &道具iconID
function Customui:getShuctIcon(playerId, ix) return 0, 0 end

--- 元件平滑移动到指定位置
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param time number @执行时间(需大于0)
--- @param x number @横坐标值
--- @param y number @竖坐标值
--- @return number @成功返回 ErrorCode.OK
function Customui:SmoothMoveTo(playerId, uiId, elementId, time, x, y) return 0 end

--- 元件平滑移动相对距离
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param time number @执行时间(需大于0)
--- @param x number @横向距离
--- @param y number @竖向距离
--- @return number @成功返回 ErrorCode.OK
function Customui:SmoothMoveBy(playerId, uiId, elementId, time, x, y) return 0 end

--- 元件平滑改变到指定 宽度 & 高度
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param time number @执行时间(需大于0)
--- @param w number @宽度
--- @param h number @高度
--- @return number @成功返回 ErrorCode.OK
function Customui:SmoothScaleTo(playerId, uiId, elementId, time, w, h) return 0 end

--- 元件平滑改变相对 宽度 & 高度
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param time number @执行时间(需大于0)
--- @param w number @宽度
--- @param h number @高度
--- @return number @成功返回 ErrorCode.OK
function Customui:SmoothScaleBy(playerId, uiId, elementId, time, w, h) return 0 end

--- 元件平滑旋转到指定角度
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param time number @执行时间(需大于0)
--- @param angle number @角度值
--- @return number @成功返回 ErrorCode.OK
function Customui:SmoothRotateTo(playerId, uiId, elementId, time, angle) return 0 end

--- 元件平滑旋转到相对角度
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param time number @执行时间(需大于0)
--- @param angle number @角度值
--- @return number @成功返回 ErrorCode.OK
function Customui:SmoothRotateBy(playerId, uiId, elementId, time, angle) return 0 end

--- 元件播放动画
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param animId number @动画ID
--- @param time number @单次时长(需大于0)
--- @param mode number @播放模式(1循环 2单次)
--- @return number @成功返回 ErrorCode.OK
function Customui:PlayElementAnim(playerId, uiId, elementId, animId, time, mode) return 0 end

--- 元件停止动画
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @return number @成功返回 ErrorCode.OK
function Customui:StopAnim(playerId, uiId, elementId) return 0 end

--- 设置装载器的模型
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param modleid string @模型ID
--- @return number @成功返回 ErrorCode.OK
function Customui:SetLoaderModel(playerId, uiId, elementId, modleid) return 0 end

--- 设置装载器的模型缩放
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param modlescale number @缩放大小
--- @return number @成功返回 ErrorCode.OK
function Customui:SetLoaderModelScale(playerId, uiId, elementId, modlescale) return 0 end

--- 设置装载器的模型方向
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param yaw number @水平角度(角度制)
--- @return number @成功返回 ErrorCode.OK
function Customui:SetLoaderModelDir(playerId, uiId, elementId, yaw) return 0 end

--- 设置装载器的模型动画
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param animId number @动画ID
--- @param playmode number @播放模式(ANIMMODE)
--- @return number @成功返回 ErrorCode.OK
function Customui:SetLoaderModelAct(playerId, uiId, elementId, animId, playmode) return 0 end

--- 滑动列表跳转到某位置
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param x number @X坐标值
--- @param y number @Y坐标值
--- @return number @成功返回 ErrorCode.OK
function Customui:TurnSliderToPos(playerId, uiId, elementId, x, y) return 0 end

--- 设置滑动列表的滑动方式
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param dir number @滑动方式(0仅左右 1仅上下 2自由滑动)
--- @return number @成功返回 ErrorCode.OK
function Customui:SetSliderDir(playerId, uiId, elementId, dir) return 0 end

--- 设置滑动条的图案
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param url string @图片库链接
--- @return number @成功返回 ErrorCode.OK
function Customui:SetSliderBarImg(playerId, uiId, elementId, url) return 0 end

--- 设置玩家界面进度条的值
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param itype number @类型枚举(1最小值 2最大值 3当前值)
--- @param value number @值
--- @return boolean @是否成功
function Customui:SetProgressBarValue(playerId, uiId, elementId, itype, value) return true end

--- 设置玩家界面进度条的纹理
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param itype number @类型枚举(1背景 2进度条)
--- @param url string @图片ID
--- @return boolean @是否成功
function Customui:SetProgressBarResId(playerId, uiId, elementId, itype, url) return true end

--- 进度条文本平滑计时
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementId string @元件ID
--- @param time number @时长
--- @param ptype number @类型枚举(1增加 2减小 3变化至)
--- @param value number @变化的值
--- @return boolean @是否成功
function Customui:SmoothIncreaseProgress(playerId, uiId, elementId, time, ptype, value) return true end

--- 克隆玩家界面元件
--- @param playerId number @玩家ID
--- @param uiId string @界面ID
--- @param elementid string @元件ID
--- @return number, string @状态码, 元件ID
function Customui:CloneElement(playerId, uiId, elementid) return 0, "" end