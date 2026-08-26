-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseTripleDropFullView.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseTripleDropFullView", package.seeall)

local CruiseTripleDropFullView = class("CruiseTripleDropFullView", BaseView)

function CruiseTripleDropFullView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "go_time/go_deadline/#txt_time")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "go_desc/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "go_desc/#scroll_desc/Viewport/#txt_desc")
	self._gotip = gohelper.findChild(self.viewGO, "go_desc/#go_tip")
	self._txttip = gohelper.findChildText(self.viewGO, "go_desc/#go_tip/#txt_tip")
	self._txtexpcount = gohelper.findChildText(self.viewGO, "go_count/go_exp/#txt_expcount")
	self._txtcoincount = gohelper.findChildText(self.viewGO, "go_count/go_coin/#txt_coincount")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CruiseTripleDropFullView:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
end

function CruiseTripleDropFullView:removeEvents()
	self._btnjump:RemoveClickListener()
end

function CruiseTripleDropFullView:_btnjumpOnClick()
	GameFacade.jump(JumpEnum.JumpView.BpView)
end

function CruiseTripleDropFullView:_editableInitView()
	self._txttime.text = ""
end

function CruiseTripleDropFullView:onUpdateParam()
	return
end

function CruiseTripleDropFullView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_2.Cruise.play_ui_tangren_yuanxiao_open)
	RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.CruiseTripleDropBtn, false)

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = self.viewParam.actId
	self._config = ActivityConfig.instance:getActivityCo(self._actId)

	self:_refreshTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	self:_refresh()
end

function CruiseTripleDropFullView:_refreshTimeTick()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function CruiseTripleDropFullView:_refresh()
	local controlCos = Activity217Config.instance:getControlCos(self._actId)
	local limitExp = Activity217Model.instance:getExpEpisodeCount(self._actId)
	local limitCoin = Activity217Model.instance:getCoinEpisodeCount(self._actId)

	self._txtexpcount.text = string.format("%s/%s", limitExp, controlCos[Activity217Enum.ActType.MultiExp].limit)
	self._txtcoincount.text = string.format("%s/%s", limitCoin, controlCos[Activity217Enum.ActType.MultiCoin].limit)
end

function CruiseTripleDropFullView:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function CruiseTripleDropFullView:onDestroyView()
	return
end

return CruiseTripleDropFullView
