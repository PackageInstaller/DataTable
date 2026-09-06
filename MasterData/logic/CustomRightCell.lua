-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/view/CustomRightCell.lua

module("logic.extensions.customfmt.view.CustomRightCell", package.seeall)

local CustomRightCell = class("CustomRightCell")

function CustomRightCell:ctor(target)
	self.mainGO = target.gameObject

	self:buildUI()
end

function CustomRightCell:buildUI()
	return
end

function CustomRightCell:setData(petMo)
	return
end

return CustomRightCell
