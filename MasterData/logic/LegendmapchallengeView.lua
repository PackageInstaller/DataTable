-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendmapchallengeView.lua

module("logic.extensions.legend.view.LegendmapchallengeView", package.seeall)

local LegendmapchallengeView = class("LegendmapchallengeView", ViewComponent)
local Block = {
	"Grass",
	"Water",
	"Fire",
	"Light",
	"Dark"
}
local State = {
	narrow = 2,
	enlarge = 1
}

function LegendmapchallengeView:ctor()
	LegendmapchallengeView.super.ctor(self)
end

function LegendmapchallengeView:buildUI()
	LegendmapchallengeView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self._filter1 = self:getGo("filter1")
	self._filter2 = self:getGo("filter2")
	self._btnALL = self:getBtn("filter1/btnALL")
	self._imgALL = goutil.findChildComponent(self.mainGO, "filter1/btnALL", "UIImageSpriteChange")
	self._txtAllColor = goutil.findChildComponent(self.mainGO, "filter1/btnALL/Text", "Text"):GetComponent("UITextColorChange")
	self._btnSSR = self:getBtn("filter1/btnSSR")
	self._imgSSR = goutil.findChildComponent(self.mainGO, "filter1/btnSSR", "UIImageSpriteChange")
	self._txtSSRColor = goutil.findChildComponent(self.mainGO, "filter1/btnSSR/Text", "Text"):GetComponent("UITextColorChange")
	self._btnSR = self:getBtn("filter1/btnSR")
	self._imgSR = goutil.findChildComponent(self.mainGO, "filter1/btnSR", "UIImageSpriteChange")
	self._txtSRColor = goutil.findChildComponent(self.mainGO, "filter1/btnSR/Text", "Text"):GetComponent("UITextColorChange")
	self._btnS = self:getBtn("filter1/btnS")
	self._imgS = goutil.findChildComponent(self.mainGO, "filter1/btnS", "UIImageSpriteChange")
	self._txtSColor = goutil.findChildComponent(self.mainGO, "filter1/btnS/Text", "Text"):GetComponent("UITextColorChange")
	self._blockList = {}

	for i = 1, 5 do
		self._blockList[i] = {}
		self._blockList[i].img = self:getGo("filter2/btn" .. Block[i] .. "/imgSelect")
		self._blockList[i].btn = self:getBtn("filter2/btn" .. Block[i])
	end

	local scrollerGo = self:getGo("scrollview")
	local cellGo = self:getGo("cell")

	self._tableview = ScrollerList.create(scrollerGo, cellGo, GameUtil.handler(self._updateCell, self))
	self._tipsNull = self:getGo("tipsNull")
	self._btnTip = self:getBtn("btnTip")
	self._selectTab = nil
end

function LegendmapchallengeView:bindEvents()
	LegendmapchallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	self._btnALL:AddClickListener(function()
		self:_onClickFilter(0)
	end, self)
	self._btnSSR:AddClickListener(function()
		self:_onClickFilter(GameEnum.PetRare.SSR)
	end, self)
	self._btnSR:AddClickListener(function()
		self:_onClickFilter(GameEnum.PetRare.SR)
	end, self)
	self._btnS:AddClickListener(function()
		self:_onClickFilter(GameEnum.PetRare.R)
	end, self)
	self._btnTip:AddClickListener(self._onClickTip, self)

	for i = 1, 5 do
		self._blockList[i].btn:AddClickListener(function()
			self:_onClickFilter(i)
		end, self)
	end
end

function LegendmapchallengeView:unbindEvents()
	LegendmapchallengeView.super.unbindEvents(self)
	self._btnALL:RemoveClickListener()
	self._btnSSR:RemoveClickListener()
	self._btnSR:RemoveClickListener()
	self._btnS:RemoveClickListener()
	self._btnTip:RemoveClickListener()

	for i = 1, 5 do
		self._blockList[i].btn:RemoveClickListener()
	end
end

function LegendmapchallengeView:destroyUI()
	LegendmapchallengeView.super.destroyUI(self)
end

function LegendmapchallengeView:onEnter()
	LegendmapchallengeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LegendMapZoom, self._refresh, self)

	local cfgs = LegendConfig.instance:getMapCfg()

	self.dataList = {}

	for k, v in pairs(cfgs) do
		table.insert(self.dataList, v)
	end

	self._selectTab1 = 0
	self._selectTab2 = 3

	self:_refresh()
end

function LegendmapchallengeView:onEnterFinished()
	LegendmapchallengeView.super.onEnterFinished(self)
end

function LegendmapchallengeView:onExit()
	LegendmapchallengeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LegendMapZoom, self._refresh, self)
	table.clear(self.dataList)
	self._tableview:dispose()
end

function LegendmapchallengeView:onExitFinished()
	LegendmapchallengeView.super.onExitFinished(self)
end

function LegendmapchallengeView:_refresh()
	local state = LegendModel.instance:getMapState()
	local blockId = LegendModel.instance:getBlockId()

	goutil.setActive(self._filter1, state == State.enlarge)
	goutil.setActive(self._filter2, state == State.narrow)

	local tempList = {}

	if state == State.enlarge then
		for k, v in ipairs(self.dataList) do
			local petCo = CharacterConfig.instance:getPetCo(v.raceId)
			local rare = petCo.rare
			local race = PetSkinConfig.instance:getFisrtEleAttrIdx(v.raceId)

			if (self._selectTab1 == 0 or rare == self._selectTab1) and blockId == race then
				local unlockId = LegendConfig.instance:getBlockCfgById(v.blockId).unlockId
				local cfg = FuncOpenConfig.instance:getFunctionOpenById(unlockId)
				local isLock = not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)

				if not isLock then
					table.insert(tempList, v)
				end
			end
		end

		self._imgALL:SetState(self._selectTab1 == 0 and 1 or 0)
		self._imgSSR:SetState(self._selectTab1 == GameEnum.PetRare.SSR and 1 or 0)
		self._imgSR:SetState(self._selectTab1 == GameEnum.PetRare.SR and 1 or 0)
		self._imgS:SetState(self._selectTab1 == GameEnum.PetRare.R and 1 or 0)
		self._txtAllColor:SetState(self._selectTab1 == 0 and 0 or 1)
		self._txtSSRColor:SetState(self._selectTab1 == GameEnum.PetRare.SSR and 0 or 1)
		self._txtSRColor:SetState(self._selectTab1 == GameEnum.PetRare.SR and 0 or 1)
		self._txtSColor:SetState(self._selectTab1 == GameEnum.PetRare.R and 0 or 1)
	else
		for k, v in ipairs(self.dataList) do
			local petCo = CharacterConfig.instance:getPetCo(v.raceId)
			local race = PetSkinConfig.instance:getFisrtEleAttrIdx(v.raceId)

			if race == self._selectTab2 then
				local unlockId = LegendConfig.instance:getBlockCfgById(v.blockId).unlockId
				local cfg = FuncOpenConfig.instance:getFunctionOpenById(unlockId)
				local isLock = not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)

				if not isLock then
					table.insert(tempList, v)
				end
			end
		end

		for i = 1, 5 do
			self._blockList[i].img.gameObject:SetActive(self._selectTab2 == i)
		end
	end

	table.sort(tempList, function(a, b)
		local petCoA = CharacterConfig.instance:getPetCo(a.raceId)
		local petCoB = CharacterConfig.instance:getPetCo(b.raceId)
		local openTimeA = GameUtil.string2time(LegendConfig.instance:getLegendChallengeCfg(a.challengeId).startTime)
		local openTimeB = GameUtil.string2time(LegendConfig.instance:getLegendChallengeCfg(b.challengeId).startTime)

		if petCoA.rare == petCoB.rare then
			if openTimeA == openTimeA then
				return a.raceId > b.raceId
			else
				return openTimeA < openTimeB
			end
		else
			return petCoA.rare > petCoB.rare
		end
	end)
	self._tableview:reloadData(tempList)
	self._tipsNull.gameObject:SetActive(#tempList == 0)
end

function LegendmapchallengeView:_updateCell(view, cell, data)
	local avatar = goutil.findChild(cell, "petIcon")
	local petName = goutil.findChildTextComponent(cell, "txtName")
	local btnChallenge = GameUtil.asBtn(goutil.findChild(cell, "btnChallenge"))
	local btnSweep = GameUtil.asBtn(goutil.findChild(cell, "btnSweep"))
	local goPass = goutil.findChild(cell, "imgPassed")
	local btnSweepSpriteChange = btnSweep:GetComponent("UIImageSpriteChange")
	local curIndependentTime = checknumber(LegendModel.instance:getCurIndependentTimes(data.challengeId))
	local isPass = LegendModel.instance:isChallengePass(data.challengeId)

	btnSweep.gameObject:SetActive(isPass)
	btnSweepSpriteChange:SetState(VipModel.instance:isVip() and 1 or 0)
	goPass.gameObject:SetActive(false)
	btnChallenge.gameObject:SetActive(not isPass)

	if not isPass then
		GameUtil.addClickHandler(btnChallenge, GameUtil.handler(self._onClickChanllenge, self, data))
	else
		GameUtil.addClickHandler(btnSweep, GameUtil.handler(self._onClickSweep, self, data))
	end

	local raceId = data.raceId
	local petCo = CharacterConfig.instance:getPetCo(raceId)

	petName.text = petCo.name

	local modelCo = CharacterConfig.instance:getModelCo(raceId)

	uGuiUtil.setSpriteToImage(avatar.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
end

function LegendmapchallengeView:_onClickChanllenge(data)
	local isUnlock = UnlockModel.instance:isFunctionUnlock(data.challengeId)

	if not isUnlock then
		return
	end

	local name = LegendConst.isNewOpen .. data.challengeId

	GameUtil.saveUserData(name, LegendConst.isNewOpenParam)

	local challengeCfg = LegendConfig.instance:getLegendChallengeCfg(data.challengeId)

	GotoMgr.gotoByString(challengeCfg.jumpTo)
end

function LegendmapchallengeView:_onClickSweep(data)
	if VipModel.instance:isVip() then
		local cfgList = LegendConfig.instance:getLegendChallengeStageCfgList(data.challengeId)

		if cfgList and #cfgList > 0 then
			local challengeId = data.challengeId
			local stageId = #cfgList

			MopupModel.instance:clickLegenSweep(challengeId, stageId)
		else
			self:_onClickChanllenge(data)
		end
	else
		self:_onClickChanllenge(data)
	end
end

function LegendmapchallengeView:_onClickFilter(type)
	if LegendModel.instance:getMapState() == State.enlarge then
		self._selectTab1 = type
	else
		self._selectTab2 = type
	end

	self:_refresh()
end

function LegendmapchallengeView:_onClickTip()
	local title = ""
	local text = string.format("激活VIP1特权可享受专属特权——<color=#%s>快捷扫荡</color>！\n快捷扫荡：<color=#%s>无需跳转</color>到<color=#%s>场景</color>中找寻找精灵进行扫荡，\n而是在此面板处<color=#%s>直接</color>进行扫荡。", ColorConst.Red, ColorConst.Red, ColorConst.Red, ColorConst.Red)
	local btnText, func

	if VipModel.instance:isVip() then
		btnText = "正在享用特权"
	else
		function func()
			FloatWordMgr.instance:show("待接入VIP入口")
		end

		btnText = "去激活"
	end

	TipsFacade.instance:openTipWindow(title, text, func, btnText, UnityEngine.TextAnchor.MiddleCenter)
end

return LegendmapchallengeView
