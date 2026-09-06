-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/corpr/view/CorPrBuffHelperView.lua

module("logic.extensions.corpr.view.CorPrBuffHelperView", package.seeall)

local CorPrBuffHelperView = class("CorPrBuffHelperView", ViewComponent)

function CorPrBuffHelperView:buildUI()
	CorPrBuffHelperView.super.buildUI(self)

	self._buffView = goutil.findChild(self.mainGO, "buffView")
	self._buffCellList = {}

	for i = 1, self._buffView.transform.childCount do
		local cell = {}

		cell._mainGo = self._buffView.transform:GetChild(i - 1)
		cell._txtNum = goutil.findChildTextComponent(cell._mainGo, "txtNum")

		table.insert(self._buffCellList, cell)
	end

	self._btnBuffTips = goutil.findChild(self.mainGO, "btnBuffTips")
	self._tipCultivate = goutil.findChild(self.mainGO, "btnBuffTips/tipCultivate")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "btnBuffTips/tipCultivate/txtTip")
	self._uiCustonInput = UICustomInput.Get(self._tipCultivate)
end

function CorPrBuffHelperView:bindEvents()
	CorPrBuffHelperView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuffTips, self._onClickBtnBuffTips, self)
	self._uiCustonInput:AddListener(self._onClickBtnBuffTips, self)
end

function CorPrBuffHelperView:unbindEvents()
	CorPrBuffHelperView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuffTips)
	self._uiCustonInput:RemoveListener()
end

function CorPrBuffHelperView:onEnter()
	CorPrBuffHelperView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._challengeId = self._customFmtMo._challengeId
	self._identityId = self._customFmtMo._identityId
	self._stageId = self._customFmtMo._stageId

	local monseterData = CorPrChallengeConfig.instance:getcpMonsterData(self._identityId, self._stageId)
	local isNeedBuffTips = not string.nilorempty(monseterData.buffDesc)

	if isNeedBuffTips then
		self._txtTip.text = monseterData.buffDesc

		local key = string.format("%s_%s_%s", self._challengeId, self._identityId, self._stageId)

		local function firstTimeCallback()
			GameUtil.SetActive(self._tipCultivate, true)
		end

		local nextTimeCallBack

		GameUtil.doCallbackWhenFirst(key, firstTimeCallback, nextTimeCallBack)
	else
		GameUtil.SetActive(self._btnBuffTips, false)
	end

	self:_onUpdate()
end

function CorPrBuffHelperView:onExit()
	CorPrBuffHelperView.super.onExit(self)
end

function CorPrBuffHelperView:_onUpdate()
	for idx, cell in ipairs(self._buffCellList) do
		GameUtil.SetActive(cell._mainGo, false)
	end

	local creepsCfg = CorPrChallengeConfig.instance:getCpCreepsCfg(self._identityId, self._stageId)

	for _, data in ipairs(creepsCfg) do
		local cell = self._buffCellList[data.posId]

		if not string.nilorempty(data.showIndex) then
			GameUtil.SetActive(cell._mainGo, true)

			cell._txtNum.text = data.showIndex
		end
	end
end

function CorPrBuffHelperView:_onClickBtnBuffTips(hover)
	if not hover then
		GameUtil.SetActive(self._tipCultivate, not GameUtil.GetActive(self._tipCultivate))
	end
end

return CorPrBuffHelperView
