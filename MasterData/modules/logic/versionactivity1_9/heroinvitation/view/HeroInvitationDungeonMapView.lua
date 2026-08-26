-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/view/HeroInvitationDungeonMapView.lua

module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapView", package.seeall)

local HeroInvitationDungeonMapView = class("HeroInvitationDungeonMapView", BaseView)

function HeroInvitationDungeonMapView:onInitView()
	self.btnInvitation = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_invitation")
	self.goNormal = gohelper.findChild(self.viewGO, "#go_topright/#btn_invitation/reward/normal")
	self._animTipsReward = self.goNormal:GetComponent(typeof(UnityEngine.Animation))
	self._goEffect = gohelper.findChild(self.goNormal, "huan")
	self.txtNormalTotal = gohelper.findChildTextMesh(self.goNormal, "layout/#txt_Total")
	self.txtNormalNum = gohelper.findChildTextMesh(self.goNormal, "layout/#txt_Num")
	self.goFinish = gohelper.findChild(self.viewGO, "#go_topright/#btn_invitation/reward/finished")
	self.goRed = gohelper.findChild(self.viewGO, "#go_topright/#btn_invitation/#go_reddot")
	self.txtFinishTotal = gohelper.findChildTextMesh(self.goFinish, "layout/#txt_Total")
	self.txtFinishNum = gohelper.findChildTextMesh(self.goFinish, "layout/#txt_Num")

	RedDotController.instance:addRedDot(self.goRed, RedDotEnum.DotNode.HeroInvitationReward, 0, self.refreshRed, self)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroInvitationDungeonMapView:addEvents()
	self.addClickCb(self, self.btnInvitation, self.onClickBtnInvitation, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.refreshInvitation, self)
	self.addEventCb(self, HeroInvitationController.instance, HeroInvitationEvent.UpdateInfo, self.refreshInvitation, self)
end

function HeroInvitationDungeonMapView:removeEvents()
	return
end

function HeroInvitationDungeonMapView:_editableInitView()
	return
end

function HeroInvitationDungeonMapView:onClickBtnInvitation()
	ViewMgr.instance:openView(ViewName.HeroInvitationView)
end

function HeroInvitationDungeonMapView:onUpdateParam()
	self:refreshView()
end

function HeroInvitationDungeonMapView:onOpen()
	self:refreshView()
	TaskDispatcher.runDelay(self._loadMap, self, 0.1)
end

function HeroInvitationDungeonMapView:_loadMap()
	local map = DungeonConfig.instance:getChapterMapCfg(DungeonModel.instance.curLookChapterId, 0)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeMap, {
		map
	})
end

function HeroInvitationDungeonMapView:onClose()
	return
end

function HeroInvitationDungeonMapView:refreshView()
	self:refreshInvitation()
end

function HeroInvitationDungeonMapView:refreshInvitation()
	local finish = HeroInvitationModel.instance.finalReward

	gohelper.setActive(self.goNormal, not finish)
	gohelper.setActive(self.goFinish, finish)

	local count, finishCount = HeroInvitationModel.instance:getInvitationFinishCount()

	self.txtNormalTotal.text = finishCount
	self.txtNormalNum.text = count
	self.txtFinishTotal.text = finishCount
	self.txtFinishNum.text = count
end

function HeroInvitationDungeonMapView:refreshRed(redIcon)
	if redIcon then
		redIcon:defaultRefreshDot()
		gohelper.setActive(self._goEffect, redIcon.show)

		if redIcon.show then
			self._animTipsReward:Play("btn_tipreward_loop")
		else
			self._animTipsReward:Play("btn_tipreward")
		end
	end
end

function HeroInvitationDungeonMapView:onDestroyView()
	TaskDispatcher.cancelTask(self._loadMap, self)
end

return HeroInvitationDungeonMapView
