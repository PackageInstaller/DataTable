-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NinePlaceMainItem.lua

module("logic.extensions.nineplace.view.NinePlaceMainItem", package.seeall)

local NinePlaceMainItem = class("NinePlaceMainItem")

function NinePlaceMainItem:ctor(go)
	self.mainGO = go

	self:buildUI()
	self:onEnter()
end

function NinePlaceMainItem:OnDestroy()
	self:onExit()
end

function NinePlaceMainItem:buildUI()
	self.lock = goutil.findChild(self.mainGO, "lock")
	self.openConBg = goutil.findChild(self.mainGO, "openConBg")
	self.openConText = goutil.findChildComponent(self.mainGO, "openConBg/text", "Text")
	self.btnText = goutil.findChildComponent(self.mainGO, "okBtn/text", "Text")
	self.titleText = goutil.findChildComponent(self.mainGO, "titleText", "Text")
	self.tipText = goutil.findChildComponent(self.mainGO, "tipText", "Text")

	local okBtn = goutil.findChild(self.mainGO, "okBtn")

	self.okBtn = GameUtil.asBtn(okBtn)
	self.imgChange = okBtn:GetComponent("UIImageSpriteChange")
	self.dot = goutil.findChild(self.mainGO, "okBtn/dot")
	self.iconChange = goutil.findChild(self.mainGO, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self.cellLightChangeList = {}

	local placeGo = goutil.findChild(self.mainGO, "place")

	for i = 1, 9 do
		self.cellLightChangeList[i] = goutil.findChild(placeGo, "cell" .. i):GetComponent(ComponentType.UIImageSpriteChange)
	end
end

function NinePlaceMainItem:onEnter()
	self.okBtn:AddClickListener(self.onClickOk, self)
end

function NinePlaceMainItem:onExit()
	self.okBtn:RemoveClickListener()
end

function NinePlaceMainItem:setData(cfg)
	self.cfg = cfg

	self:initView()
end

function NinePlaceMainItem:initView()
	self.titleText.text = self.cfg.name

	self.iconChange:ChangeSprite(self.cfg.mainIconResName)

	local lightsTemp = {}

	for i, v in ipairs(self.cfg.lights) do
		lightsTemp[v] = true
	end

	for i = 1, 9 do
		self.cellLightChangeList[i]:SetState(lightsTemp[i] and 1 or 0)
	end

	local open = FuncOpenController.instance:getConditionReached(self.cfg.openCondition)
	local isPass = NinePlaceModel.instance:isStagePass(self.cfg.stageId)

	GameUtil.SetActive(self.openConBg, not open)
	GameUtil.SetActive(self.lock, not open)

	self.btnText.text = isPass and "已通关" or "挑战"

	self.imgChange:SetState(isPass and 1 or 0)

	self.isOpen = open

	if not open then
		self.openConText.text = self.cfg.lockTip
	end

	self.tipText.text = self.cfg.description
	self.isPass = isPass

	GameUtil.SetActive(self.dot, NinePlaceModel.instance:checkStageCanChallenge(self.cfg.stageId))
end

function NinePlaceMainItem:onClickOk()
	if self.isPass then
		FloatWordMgr.instance:show("当前关卡已通关")

		return
	end

	if self.isOpen then
		NinePlaceModel.instance.currViewStageId = self.cfg.stageId

		UIStateManager.instance:push(ViewName.NineplacechallengeView, self.cfg.stageId)
	else
		FloatWordMgr.instance:show(self.cfg.lockTip)
	end
end

return NinePlaceMainItem
