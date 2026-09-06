-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/forceslide/ForceSlideTipsView.lua

module("logic.extensions.forceslide.view.ForceSlideTipsView", package.seeall)

local ForceSlideTipsView = class("ForceSlideTipsView", ViewComponent)
local ForceSlideGroups = {
	ForceSlideModel.DataType.GainLongYan,
	ForceSlideModel.DataType.SavePet,
	ForceSlideModel.DataType.RepairStrength,
	ForceSlideModel.DataType.DefeatPet
}

function ForceSlideTipsView:ctor()
	ForceSlideTipsView.super.ctor(self)
end

function ForceSlideTipsView:unbindEvents()
	ForceSlideTipsView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function ForceSlideTipsView:bindEvents()
	ForceSlideTipsView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function ForceSlideTipsView:buildUI()
	ForceSlideTipsView.super.buildUI(self)

	self._content = self:getGo("content")
	self._adjustPosition = UIAdjustPosition.Get(self._content)
	self._customInput = UICustomInput.Get(self._content)
	self._tipsContainer = self:getGo("content/scroll/Viewport/Content")
	self._tipsTxtTemplate = goutil.findChild(self._tipsContainer, "cell")

	self._tipsTxtTemplate:SetActive(false)

	self._subItems = {}

	local rect = self._content.gameObject:GetComponent("RectTransform")

	if rect ~= nil then
		self._sizeDelta = {
			rect.sizeDelta.x,
			rect.sizeDelta.y
		}
	end
end

function ForceSlideTipsView:_destroyText()
	for _, txt in ipairs(self._subItems) do
		goutil.destroy(txt)
	end

	self._subItems = {}
end

function ForceSlideTipsView:onExit()
	ForceSlideTipsView.super.onExit(self)
	self:_destroyText()
end

function ForceSlideTipsView:onEnter()
	ForceSlideTipsView.super.onEnter(self)
	self:_destroyText()

	local params = self:getOpenParam()
	local index = params[1]

	index = index and checknumber(index) or 1

	if index == 1 then
		self:_setRepairTips()
	else
		self:_setDestoryTips()
	end

	local goRelative = params[2]

	if goRelative and goRelative.gameObject then
		local pos = goRelative.gameObject.transform.position
		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)

		local offsetX = self._sizeDelta[1] * 0.5
		local halfWidth = UnityEngine.Screen.width * 0.5

		pos.x = halfWidth > pos.x and pos.x - offsetX or pos.x + offsetX
		pos.y = pos.y + 18

		Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
		self._adjustPosition:AdjustScreenPosition(pos)
	end
end

function ForceSlideTipsView:_insertCol(content)
	local cell = goutil.cloneAndSetParent(self._tipsTxtTemplate, self._tipsContainer.transform)

	cell:SetActive(true)

	local txt = goutil.findChildTextComponent(cell, "txt")

	txt.text = content

	table.insert(self._subItems, cell)
end

function ForceSlideTipsView:_setRepairTips()
	local model = ForceSlideModel.instance
	local activityId = model:getActivityId()

	self:_insertCol(lang(ForceSlideConfig.instance:getCommonValue("TIP_TITLE_1")))

	for _, v in ipairs(ForceSlideGroups) do
		local value = model:getTabValue(v)

		if value > 0 then
			local conf = ForceSlideConfig.instance:getTabConf(activityId, v)

			self:_insertCol(langPara(conf.desc, value))
		end
	end
end

function ForceSlideTipsView:_setDestoryTips()
	local activityId = ForceSlideModel.instance:getActivityId()
	local confs = ForceSlideConfig.instance:getWordConfs(activityId)
	local nowTime = ServerTime.nowServerLook()

	self:_insertCol(lang(ForceSlideConfig.instance:getCommonValue("TIP_TITLE_2")))

	for i = 1, #confs do
		local conf = confs[i]
		local timeStart = GameUtil.string2time(conf.startTime)

		if timeStart <= nowTime then
			self:_insertCol(lang(conf.words))
		end
	end
end

function ForceSlideTipsView:_onCustomInputCallback(bInside)
	if not bInside then
		self:close()
	end
end

return ForceSlideTipsView
