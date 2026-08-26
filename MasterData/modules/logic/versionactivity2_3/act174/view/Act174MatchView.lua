-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174MatchView.lua

module("modules.logic.versionactivity2_3.act174.view.Act174MatchView", package.seeall)

local Act174MatchView = class("Act174MatchView", BaseView)
local TXT_NUM = 6

function Act174MatchView:onInitView()
	self._gosearching = gohelper.findChild(self.viewGO, "#go_searching")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searching/#btn_cancel")
	self._txtsearching = gohelper.findChildText(self.viewGO, "#go_searching/#txt_searching")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._btncancelgrey = gohelper.findChildButtonWithAudio(self.viewGO, "#go_success/#btn_cancel_grey")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174MatchView:addEvents()
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btncancelgrey:AddClickListener(self._btncancelgreyOnClick, self)
	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)
end

function Act174MatchView:removeEvents()
	self._btncancel:RemoveClickListener()
	self._btncancelgrey:RemoveClickListener()
end

function Act174MatchView:_btncancelOnClick()
	AudioMgr.instance:trigger(AudioEnum.Act174.stop_ui_shenghuo_dqq_match_success)
	self:closeThis()
end

function Act174MatchView:_btncancelgreyOnClick()
	return
end

function Act174MatchView:_onEscBtnClick()
	if self._btncancelgrey.gameObject.activeInHierarchy then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Act174.stop_ui_shenghuo_dqq_match_success)
	self:closeThis()
end

function Act174MatchView:_editableInitView()
	self.txtList = {}

	for i = 1, TXT_NUM do
		self.txtList[#self.txtList + 1] = gohelper.findChildText(self.viewGO, "#go_searching/searching/#txt_searching" .. i)
	end
end

function Act174MatchView:onUpdateParam()
	return
end

function Act174MatchView:onOpen()
	self:setRandomTxt()

	local waitTime = lua_activity174_const.configDict[Activity174Enum.ConstKey.MatchWaitTime].value

	TaskDispatcher.runDelay(self.waitEnd, self, tonumber(waitTime))
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_match_success)
end

function Act174MatchView:setRandomTxt()
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))

	local allStr = lua_activity174_const.configDict[Activity174Enum.ConstKey.MatchTxt].value2
	local strList = string.split(allStr, "#")
	local strLength = #strList

	for i = 1, TXT_NUM do
		local randomIndex = math.random(i, strLength)

		strList[i] = strList[randomIndex]
		strList[randomIndex] = strList[i]
	end

	for i, txt in ipairs(self.txtList) do
		txt.text = strList[i]
	end
end

function Act174MatchView:onClose()
	TaskDispatcher.cancelTask(self.waitEnd, self)
end

function Act174MatchView:onDestroyView()
	return
end

function Act174MatchView:waitEnd()
	local actId = Activity174Model.instance:getCurActId()

	Activity174Rpc.instance:sendStartAct174FightMatchRequest(actId, self.matchCallback, self)
end

function Act174MatchView:matchCallback()
	gohelper.setActive(self._gosearching, false)
	gohelper.setActive(self._gosuccess, true)
	Activity174Controller.instance:openFightReadyView()
	ViewMgr.instance:closeView(ViewName.Act174GameView, true)
	self:closeThis()
end

return Act174MatchView
