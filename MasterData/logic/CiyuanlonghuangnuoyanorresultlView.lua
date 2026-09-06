-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanlonghuangnuoya/view/CiyuanlonghuangnuoyanorresultlView.lua

module("logic.extensions.ciyuanlonghuangnuoya.view.CiyuanlonghuangnuoyanorresultlView", package.seeall)

local CiyuanlonghuangnuoyanorresultlView = class("CiyuanlonghuangnuoyanorresultlView", ViewComponent)

function CiyuanlonghuangnuoyanorresultlView:unbindEvents()
	CiyuanlonghuangnuoyanorresultlView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnOk)
end

function CiyuanlonghuangnuoyanorresultlView:bindEvents()
	CiyuanlonghuangnuoyanorresultlView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnOk, self._onClickOK, self)
end

function CiyuanlonghuangnuoyanorresultlView:buildUI()
	CiyuanlonghuangnuoyanorresultlView.super.buildUI(self)

	self._btnOk = self:getGo("btnOk")
	self._txtDesc = self:getTxt("txtDesc")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
end

function CiyuanlonghuangnuoyanorresultlView:onExit()
	CiyuanlonghuangnuoyanorresultlView.super.onExit(self)
end

function CiyuanlonghuangnuoyanorresultlView:onEnter()
	CiyuanlonghuangnuoyanorresultlView.super.onEnter(self)

	local pb = self:getFirstParam()

	if pb == nil then
		self:close()
	else
		self._activityId = pb.activityId
		self._curFightStageId = pb.curFightStageId
		self._info = CiyuanlonghuangnuoyaModel.instance:getInfo(self._activityId) or {}

		local last = 0

		if not self._info.stageInfo then
			for i, v in pairs(self._info.stageInfo) do
				if v.stageId == self._curFightStageId then
					last = v.timeScore

					break
				end
			end

			local curFightTotalTimeScore = checknumber(pb.curFightTotalTimeScore)

			if not pb.curFightBalanceInfo then
				local arr = {}

				for i, v in ipairs(pb.curFightBalanceInfo) do
					local planId = v.left
					local cfg = CiyuanlonghuangnuoyaConfig.instance:getPlanCfgById(planId)

					if cfg then
						local desc = langPara(cfg.desc, v.right)

						table.insert(arr, desc)
					end
				end

				self._txtDesc.text = langPara("本次获得时间点数：%s\n%s\n\n本关当前时间点数：%s", curFightTotalTimeScore, table.concat(arr, ","), last)
			end
		end
	end
end

function CiyuanlonghuangnuoyanorresultlView:_onClickOK()
	BattleController.instance:endBattle()
	self:close()
end

return CiyuanlonghuangnuoyanorresultlView
