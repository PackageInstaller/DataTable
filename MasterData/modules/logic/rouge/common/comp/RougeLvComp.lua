-- chunkname: @modules/logic/rouge/common/comp/RougeLvComp.lua

module("modules.logic.rouge.common.comp.RougeLvComp", package.seeall)

local RougeLvComp = class("RougeLvComp", UserDataDispose)
local Delay2HideTalentEffectDuration = 3

function RougeLvComp.Get(go)
	local comp = RougeLvComp.New()

	comp:init(go)

	return comp
end

function RougeLvComp:init(go)
	self:__onInit()

	self.go = go

	self:_editableInitView()
end

function RougeLvComp:_editableInitView()
	self._imageTypeIcon = gohelper.findChildImage(self.go, "Root/#image_TypeIcon")
	self._txttalent = gohelper.findChildText(self.go, "Root/#txt_talent")
	self._txttotal = gohelper.findChildText(self.go, "Root/#txt_total")
	self._txtLv = gohelper.findChildText(self.go, "Root/#txt_Lv")
	self._txtTypeName = gohelper.findChildText(self.go, "Root/#txt_TypeName")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "Root/#btn_click")
	self._goeffect = gohelper.findChild(self.go, "Root/effect")
	self._gomagic = gohelper.findChild(self.go, "Root/magic")
	self._goeffectget = gohelper.findChild(self.go, "Root/effect_get")

	local costTalentPoint = RougeConfig1.instance:getConstValueByID(RougeEnum.Const.TalentCost)

	self._costTalentPoint = tonumber(costTalentPoint)

	self:addEvents()
end

function RougeLvComp:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeInfoTeamValues, self.refreshLV, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeInfo, self.refreshLV, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeInfoPower, self.refreshPower, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeInfoTalentPoint, self.onUpdateTalentPoint, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinishCallBack, self)
end

function RougeLvComp:onOpen()
	self.rougeInfo = RougeModel.instance:getRougeInfo()

	if not self.rougeInfo or not self.rougeInfo.season then
		return
	end

	self:refreshUI()
end

function RougeLvComp:refreshUI()
	self:refreshStyle()
	self:refreshLV()
	self:refreshPower()
	self:refreshTalentEffect()
end

function RougeLvComp:refreshTalentEffect()
	local info = RougeModel.instance:getRougeInfo()
	local talentPoint = info.talentPoint
	local showEffect = talentPoint >= self._costTalentPoint

	if showEffect then
		local talentList = info.talentInfo
		local len = #talentList
		local lastRightInfo = talentList[len]
		local lastLeftInfo = talentList[len - 1]

		if lastLeftInfo.isActive == 1 or lastRightInfo.isActive == 1 then
			showEffect = false
		end
	end

	gohelper.setActive(self._goeffect, showEffect)
end

function RougeLvComp:refreshStyle()
	local style = self.rougeInfo.style
	local season = self.rougeInfo.season
	local styleCo = lua_rouge_style.configDict[season][style]

	UISpriteSetMgr.instance:setRouge2Sprite(self._imageTypeIcon, string.format("%s_light", styleCo.icon))

	self._txtTypeName.text = styleCo.name
end

function RougeLvComp:refreshLV()
	self._txtLv.text = "Lv." .. self.rougeInfo.teamLevel
end

function RougeLvComp:refreshPower()
	local rougeInfo = self.rougeInfo

	if not self.prePower then
		self._txttalent.text = rougeInfo.power
		self.prePower = rougeInfo.power
	elseif self.prePower ~= rougeInfo.power then
		self:killTween()
		gohelper.setActive(self._gomagic, false)
		gohelper.setActive(self._gomagic, true)

		self.tweenId = ZProj.TweenHelper.DOTweenFloat(self.prePower, rougeInfo.power, RougeMapEnum.PowerChangeDuration, self.frameCallback, self.doneCallback, self)

		AudioMgr.instance:trigger(AudioEnum.UI.DecreasePower)
	end

	self._txttotal.text = rougeInfo.powerLimit
end

function RougeLvComp:frameCallback(value)
	value = math.ceil(value)
	self._txttalent.text = value
	self.prePower = value
end

function RougeLvComp:doneCallback()
	self.tweenId = nil
end

function RougeLvComp:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function RougeLvComp:onUpdateTalentPoint()
	local isTop = RougeMapHelper.checkMapViewOnTop()

	if not isTop then
		self._waitUpdate = true

		return
	end

	self._waitUpdate = nil

	self:refreshTalentEffect()
	gohelper.setActive(self._goeffectget, true)
	TaskDispatcher.cancelTask(self._hideTalentGetEffect, self)
	TaskDispatcher.runDelay(self._hideTalentGetEffect, self, Delay2HideTalentEffectDuration)
end

function RougeLvComp:onCloseViewFinishCallBack()
	if self._waitUpdate then
		self:onUpdateTalentPoint()
	end
end

function RougeLvComp:_hideTalentGetEffect()
	gohelper.setActive(self._goeffectget, false)
end

function RougeLvComp:onClose()
	return
end

function RougeLvComp:_btnclickOnClick()
	RougeController.instance:openRougeTalentView()
end

function RougeLvComp:destroy()
	self:killTween()
	self._btnclick:RemoveClickListener()
	TaskDispatcher.cancelTask(self._hideTalentGetEffect, self)
	self:__onDispose()
end

return RougeLvComp
