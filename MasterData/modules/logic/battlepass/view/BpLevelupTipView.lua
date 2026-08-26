-- chunkname: @modules/logic/battlepass/view/BpLevelupTipView.lua

module("modules.logic.battlepass.view.BpLevelupTipView", package.seeall)

local BpLevelupTipView = class("BpLevelupTipView", BaseView)

function BpLevelupTipView:onInitView()
	self._animationEvent = gohelper.findChild(self.viewGO, "root"):GetComponent(typeof(ZProj.AnimationEventWrap))
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_bg")
	self._txtlv = gohelper.findChildText(self.viewGO, "root/main/icon/#txt_lv")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BpLevelupTipView:addEvents()
	self._btnClose:AddClickListener(self.onCloseClick, self)
	self._animationEvent:AddEventListener("levelup", self.onLevelUp, self)
end

function BpLevelupTipView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._animationEvent:RemoveEventListener("levelup")
end

function BpLevelupTipView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getBpBg("full/img_shengji_bg"))

	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)

	if BpModel.instance.preStatus then
		if not BpModel.instance.preStatus.score then
			local score = BpModel.instance.score

			self._txtlv.text = math.floor(score / levelScore)
			self._openTime = ServerTime.now()

			TaskDispatcher.runDelay(self.onCloseClick, self, BpEnum.LevelUpTotalTime)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_permit_decibel_upgrade)
		end
	end
end

function BpLevelupTipView:onUpdateParam()
	return
end

function BpLevelupTipView:onLevelUp()
	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local currentLv = math.floor(BpModel.instance.score / levelScore)

	BpController.instance:dispatchEvent(BpEvent.OnLevelUp, currentLv)

	self._txtlv.text = currentLv

	if not BpModel.instance.preStatus then
		return
	end

	StatController.instance:track(StatEnum.EventName.BPUp, {
		[StatEnum.EventProperties.BP_Type] = StatEnum.BpType[BpModel.instance.payStatus],
		[StatEnum.EventProperties.BeforeLevel] = math.floor(BpModel.instance.preStatus.score / levelScore),
		[StatEnum.EventProperties.AfterLevel] = currentLv,
		[StatEnum.EventProperties.BP_ID] = tostring(BpModel.instance.id)
	})
end

function BpLevelupTipView:onCloseClick()
	if not self._openTime or ServerTime.now() - self._openTime < BpEnum.LevelUpMinTime then
		return
	end

	self:closeThis()
end

function BpLevelupTipView:onOpen()
	return
end

function BpLevelupTipView:onClose()
	if not BpModel.instance:isInFlow() then
		BpController.instance:dispatchEvent(BpEvent.ShowUnlockBonusAnim)
	end

	TaskDispatcher.cancelTask(self.onCloseClick, self)
end

function BpLevelupTipView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return BpLevelupTipView
