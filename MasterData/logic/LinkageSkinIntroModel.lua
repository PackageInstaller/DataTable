-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageskinintro/model/LinkageSkinIntroModel.lua

module("logic.extensions.linkageskinintro.model.LinkageSkinIntroModel", package.seeall)

local LinkageSkinIntroModel = class("LinkageSkinIntroModel", BaseModel)

LinkageSkinIntroModel.ReadFlag = "LinkageSkinIntroModel.ReadFlag"

function LinkageSkinIntroModel:ctor()
	LinkageSkinIntroModel.super.ctor(self)

	self._tabCount = #LinkageSkinIntroConfig.instance:getTabsCfg().dataList
end

function LinkageSkinIntroModel:onInit()
	self:onReset()
end

function LinkageSkinIntroModel:onReset()
	self:refreshRedpointOnStart()
end

function LinkageSkinIntroModel:haveRedPointOnTab(idx)
	local tabsCfg = LinkageSkinIntroConfig.instance:getTabsCfg()
	local isOpen = ServerTime.now() - GameUtil.string2time(tabsCfg[idx].openTime) >= 0

	if GameUtil.getUserData(LinkageSkinIntroModel.ReadFlag .. idx) == true or isOpen == false then
		return false
	else
		return true
	end
end

function LinkageSkinIntroModel:setReadStaus(idx)
	GameUtil.saveUserData(LinkageSkinIntroModel.ReadFlag .. idx, true)
end

function LinkageSkinIntroModel:haveRedPoint()
	for i = 1, self._tabCount do
		if self:haveRedPointOnTab(i) then
			return true
		end
	end

	return false
end

function LinkageSkinIntroModel:refreshRedpoint()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_LINKAGE_SKIN_INTRO, self:haveRedPoint())
end

function LinkageSkinIntroModel:refreshRedpointOnStart()
	self._checkList = {}
	self._dataResult = {}

	for i = 1, self._tabCount do
		table.insert(self._checkList, false)
		GameUtil.getUserData(LinkageSkinIntroModel.ReadFlag .. i, function(result)
			self._checkList[i] = true
			self._dataResult[i] = result

			for i = 1, self._tabCount do
				if self._checkList[i] == false then
					return
				end
			end

			self:checkRedPointOnStart()
		end)
	end
end

function LinkageSkinIntroModel:checkRedPointOnStart()
	local result = false
	local tabsCfg = LinkageSkinIntroConfig.instance:getTabsCfg()

	for i = 1, self._tabCount do
		local isOpen = ServerTime.now() - GameUtil.string2time(tabsCfg[i].openTime) >= 0

		if self._dataResult[i] ~= true and isOpen == true then
			result = true

			break
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_LINKAGE_SKIN_INTRO, result)
end

LinkageSkinIntroModel.instance = LinkageSkinIntroModel.New()

return LinkageSkinIntroModel
