--- @class DisPlayBoard
--- 显示板管理接口 DisPlayBoard
local DisPlayBoard = {}
_G.DisPlayBoard = DisPlayBoard

--- 对玩家显示显示板
--- @param playerid number @玩家ID
--- @param boardid number @显示板ID
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function DisPlayBoard:showBoard(playerid, boardid) return 0 end

--- 对玩家隐藏显示板
--- @param playerid number @玩家ID
--- @param boardid number @显示板ID
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function DisPlayBoard:hideBoard(playerid, boardid) return 0 end

--- 对玩家设置显示板的图片
--- @param playerid number @玩家ID
--- @param boardid number @显示板ID
--- @param pictureid string @图片ID
--- @return number @成功返回 ErrorCode.OK，失败返回 ErrorCode
function DisPlayBoard:setBoardPicture(playerid, boardid, pictureid) return 0 end
