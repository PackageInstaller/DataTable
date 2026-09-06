-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchBossExtView.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchBossExtView", package.seeall)

local SummerTreasureSnatchBossExtView = class("SummerTreasureSnatchBossExtView", ViewComponent)

function SummerTreasureSnatchBossExtView:ctor()
	SummerTreasureSnatchBossExtView.super.ctor(self)
end

function SummerTreasureSnatchBossExtView:unbindEvents()
	SummerTreasureSnatchBossExtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuff)
end

function SummerTreasureSnatchBossExtView:bindEvents()
	SummerTreasureSnatchBossExtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function SummerTreasureSnatchBossExtView:buildUI()
	SummerTreasureSnatchBossExtView.super.buildUI(self)

	self._btnBuff = self:getGo("btnBuff")
	self._imgBuff = self:getGo("btnBuff/imgBuff")
	self._bubble = self:getGo("bubble")
	self._txtBuffName = self:getTxt("btnBuff/imgBg/txtBuffName")
	self._txtDesc = self:getTxt("bubble/txtDesc")
end

function SummerTreasureSnatchBossExtView:onExit()
	SummerTreasureSnatchBossExtView.super.onExit(self)
	uGuiUtil.clearImage(self._imgBuff)
end

function SummerTreasureSnatchBossExtView:onEnter()
	SummerTreasureSnatchBossExtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SummerTreasureSnatchChooseBuff, self._chooseBuff, self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo:getActivityId()
	self._buffId = self._fmtMo:getBuffId()
	self._buffIdList = SummerTreasureSnatchModel.instance:getBuffIdList(self._activityId)

	if self._buffId <= 0 then
		if #self._buffIdList > 0 then
			self:_chooseBuff(self._buffIdList[1])
		end
	else
		self:_chooseBuff(self._buffId)
	end

	self:_onUpdate()
end

function SummerTreasureSnatchBossExtView:_onUpdate()
	self._txtBuffName.text = lang("增益选择")

	if self._buffId > 0 then
		local buffCfg = SummerTreasureSnatchConfig.instance:getBuffCfg(self._activityId, self._buffId)

		self._txtBuffName.text = buffCfg.name
		self._txtDesc.text = buffCfg.desc

		uGuiUtil.setSpriteToImage(self._imgBuff, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(buffCfg.icon))
	end

	GameUtil.SetActive(self._imgBuff, self._buffId > 0)
	GameUtil.SetActive(self._bubble, self._buffId > 0)
end

function SummerTreasureSnatchBossExtView:_onClickBuff()
	local info = SummerTreasureSnatchModel.instance:getInfo(self._activityId)
	local buffCfgs = SummerTreasureSnatchConfig.instance:getBuffCfgs(self._activityId)

	local function callBackFunc(buffId)
		self:_chooseBuff(buffId)
	end

	CustomFmtController.instance:openBuffView(ViewName.BuffChooseViewNoBg, self._buffIdList, buffCfgs, callBackFunc, self._buffId, lang("祝福可前往商店获得"))
end

function SummerTreasureSnatchBossExtView:_chooseBuff(buffId)
	self._fmtMo:setBuffId(buffId)

	self._buffId = buffId

	self:_onUpdate()
end

return SummerTreasureSnatchBossExtView
