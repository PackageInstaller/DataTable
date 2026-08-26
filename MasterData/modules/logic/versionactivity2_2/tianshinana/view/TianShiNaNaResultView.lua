-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaResultView.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaResultView", package.seeall)

local TianShiNaNaResultView = class("TianShiNaNaResultView", BaseView)

function TianShiNaNaResultView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._txtclassnum = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classnum")
	self._txtclassname = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classname")
	self._gotarget = gohelper.findChild(self.viewGO, "targets")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")
	self._btnrollback = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_rollback")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TianShiNaNaResultView:addEvents()
	self._btnclose:AddClickListener(self.exitGame, self)
	self._btnquitgame:AddClickListener(self.exitGame, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnrollback:AddClickListener(self._btnrollbackOnClick, self)
end

function TianShiNaNaResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnrollback:RemoveClickListener()
end

function TianShiNaNaResultView:exitGame()
	if self._isWin then
		TianShiNaNaModel.instance:markEpisodeFinish(self._index, self.viewParam.star)
	end

	ViewMgr.instance:closeView(ViewName.TianShiNaNaLevelView)
	self:closeThis()
end

function TianShiNaNaResultView:onClickModalMask()
	self:exitGame()
end

function TianShiNaNaResultView:_btnrestartOnClick()
	Activity167Rpc.instance:sendAct167ReStartEpisodeRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id)
	self:closeThis()
end

function TianShiNaNaResultView:_btnrollbackOnClick()
	Activity167Rpc.instance:sendAct167RollbackRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id)
	self:closeThis()
end

function TianShiNaNaResultView:_editableInitView()
	gohelper.setActive(self._gotargetitem, false)

	self._taskItems = {}
end

function TianShiNaNaResultView:onOpen()
	self._isWin = self.viewParam.isWin

	if self._isWin then
		TianShiNaNaModel.instance:sendStat("成功")
	else
		TianShiNaNaModel.instance:sendStat("失败")
	end

	self._episodeCfg = TianShiNaNaModel.instance.episodeCo

	self:refreshUI()
end

function TianShiNaNaResultView:refreshUI()
	if self._episodeCfg then
		local stageCoList = TianShiNaNaConfig.instance:getEpisodeCoList(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
		local index = tabletool.indexOf(stageCoList, self._episodeCfg) or 1

		self._index = index
		self._txtclassnum.text = string.format("STAGE %02d", index)
		self._txtclassname.text = self._episodeCfg.name

		gohelper.setActive(self._gotarget, self._isWin)

		if self._isWin then
			AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
			self:refreshTaskConditions()
		else
			AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
		end

		gohelper.setActive(self._gosuccess, self._isWin)
		gohelper.setActive(self._gofail, not self._isWin)
		gohelper.setActive(self._btnquitgame, not self._isWin)
		gohelper.setActive(self._btnrestart, not self._isWin)
		gohelper.setActive(self._btnrollback, not self._isWin)
		gohelper.setActive(self._btnclose, self._isWin)
	end
end

function TianShiNaNaResultView:refreshTaskConditions()
	local episodeCfg = self._episodeCfg
	local strs = string.split(episodeCfg.conditionStr, "#")

	gohelper.CreateObjList(self, self._createItem, strs, self._gotargetitem.transform.parent.gameObject, self._gotargetitem)
end

function TianShiNaNaResultView:_createItem(obj, data, index)
	local txt = gohelper.findChildTextMesh(obj, "txt_taskdesc")
	local finish = gohelper.findChild(obj, "result/go_finish")
	local unfinish = gohelper.findChild(obj, "result/go_unfinish")

	txt.text = data

	gohelper.setActive(finish, index <= self.viewParam.star)
	gohelper.setActive(unfinish, index > self.viewParam.star)
end

return TianShiNaNaResultView
