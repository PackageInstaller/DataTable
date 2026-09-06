-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachingDungeonTabItem.lua

module("logic.extensions.teachingdungeon.TeachingDungeonTabItem", package.seeall)

local TeachingDungeonTabItem = class("TeachingDungeonTabItem")

function TeachingDungeonTabItem.AddOnce(go)
	return GameUtil.AddLuaOnce(go, TeachingDungeonTabItem)
end

function TeachingDungeonTabItem.Remove(go)
	local obj = GameUtil.GetLua(go, TeachingDungeonTabItem)

	if obj ~= nil then
		obj:dispose()
	end

	GameUtil.RemoveLua(go, TeachingDungeonTabItem)
end

function TeachingDungeonTabItem:ctor(go)
	self.model = TeachingDungeonModel.instance
	self.mainGO = go.gameObject
	self.isGray = false

	self:buildUI()
	self:initEvent()
end

function TeachingDungeonTabItem:dispose()
	return
end

function TeachingDungeonTabItem:OnDestroy()
	self:unbindEvent()
end

function TeachingDungeonTabItem:unbindEvent()
	GameUtil.asBtn(self.mainGO):RemoveClickListener()
end

function TeachingDungeonTabItem:initEvent()
	GameUtil.asBtn(self.mainGO):AddClickListener(function(eventData)
		self:_clickGo()
	end)
end

function TeachingDungeonTabItem:buildUI()
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._goImgYtg = goutil.findChild(self.mainGO, "imgYtg")
	self._goImgLock = goutil.findChild(self.mainGO, "imgLock")
	self._goImgDot = goutil.findChild(self.mainGO, "imgDot")
	self._changeGroup = self.mainGO:GetComponent("UIChangeGroup")
	self._imgPerfect = goutil.findChild(self.mainGO, "imgPerfect")
end

function TeachingDungeonTabItem:setData(data, currStageId, callBack)
	self._txtName.text = data.stageName
	self.callBack = callBack
	self.data = data

	local isOpen = self.model:isStageOpen(data.stageId)

	GameUtil.SetActive(self._goImgYtg, self.model:isStagePass(data.stageId))
	GameUtil.SetActive(self._goImgLock, not isOpen)
	GameUtil.SetActive(self._goImgDot, TeachingDungeonModel.instance:isStageCanChallenge(data.stageId))
	GameUtil.SetActive(self._imgPerfect, TeachingDungeonModel.instance:isStagePerfectPass(data.stageId))
	self._changeGroup:SetState(not isOpen and 2 or data.stageId == currStageId and 0 or 1)
end

function TeachingDungeonTabItem:_clickGo()
	if self.callBack and self.data then
		self.callBack(self.data.stageId)
	end
end

function TeachingDungeonTabItem:_setItemStateShow()
	return
end

return TeachingDungeonTabItem
