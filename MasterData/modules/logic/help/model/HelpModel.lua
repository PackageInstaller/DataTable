-- chunkname: @modules/logic/help/model/HelpModel.lua

module("modules.logic.help.model.HelpModel", package.seeall)

local HelpModel = class("HelpModel", BaseModel)

function HelpModel:onInit()
	self._targetPageIndex = 0
end

function HelpModel:reInit()
	self._targetPageIndex = 0
end

function HelpModel:setTargetPageIndex(index)
	self._targetPageIndex = index
end

function HelpModel:getTargetPageIndex()
	return self._targetPageIndex
end

function HelpModel:updateShowedHelpId()
	local property = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.ShowHelpIds)

	self.showedHelpIdList = string.nilorempty(property) and {} or string.sub(property, 1, 1) == "L" and NumberCompressUtil.decompress(string.sub(property, 2)) or string.splitToNumber(PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.ShowHelpIds), "#")
end

function HelpModel:isShowedHelp(helpId)
	if not helpId then
		return false
	end

	for _, showedHelpId in ipairs(self.showedHelpIdList) do
		if showedHelpId == helpId then
			return true
		end
	end

	return false
end

function HelpModel:setShowedHelp(helpId)
	if not helpId then
		return
	end

	if self:isShowedHelp(helpId) then
		return
	end

	table.insert(self.showedHelpIdList, helpId)
	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.ShowHelpIds, "L" .. NumberCompressUtil.compress(self.showedHelpIdList))
end

HelpModel.instance = HelpModel.New()

return HelpModel
