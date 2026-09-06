-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/view/ViprecordView.lua

module("logic.extensions.vip.view.ViprecordView", package.seeall)

local ViprecordView = class("ViprecordView", ViewComponent)

function ViprecordView:ctor()
	ViprecordView.super.ctor(self)
end

function ViprecordView:buildUI()
	ViprecordView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._cellRecord = {}

	for i = 1, 10 do
		local cell = {}

		cell.go = self:getGo("record/infos/cell" .. i)
		cell.mark = goutil.findChild(cell.go, "imgExpired")
		cell.txtMoney = goutil.findChildTextComponent(cell.go, "txtMoney")
		cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")

		table.insert(self._cellRecord, cell)
	end

	self._btnBefore = self:getBtn("record/page/btnBefore")
	self._btnAfter = self:getBtn("record/page/btnAfter")
	self._txtPage = self:getTxt("record/page/txtPage")

	local tableInfo = self:getGo("rule/table/Viewport/Content")
	local cellInfo = goutil.findChild(tableInfo, "info")
	local rulesCfg = RulesConfig.instance:getRuleCo("vipRule")

	if rulesCfg and rulesCfg.rules then
		local strs = string.split(rulesCfg.rules, "\n")

		for _, str in pairs(strs) do
			if not GameUtil.isEmptyString(str) then
				local go = goutil.clone(cellInfo)
				local txt = go:GetComponent("Text")

				goutil.addChildToParent(go, tableInfo)

				txt.text = str

				goutil.setActive(go, true)
			end
		end
	end
end

function ViprecordView:bindEvents()
	ViprecordView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnBefore:AddClickListener(function()
		self:MovePage(false)
	end, self)
	self._btnAfter:AddClickListener(function()
		self:MovePage(true)
	end, self)
end

function ViprecordView:unbindEvents()
	ViprecordView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBefore:RemoveClickListener()
	self._btnAfter:RemoveClickListener()
end

function ViprecordView:destroyUI()
	ViprecordView.super.destroyUI(self)
end

function ViprecordView:onEnter()
	ViprecordView.super.onEnter(self)
	VipController.instance:sendVipExpRecordReq(self._initRecord, self)
end

function ViprecordView:onEnterFinished()
	ViprecordView.super.onEnterFinished(self)
end

function ViprecordView:onExit()
	ViprecordView.super.onExit(self)
end

function ViprecordView:onExitFinished()
	ViprecordView.super.onExitFinished(self)
end

function ViprecordView:MovePage(isMoveNext)
	local lastPage = self._curPage

	if isMoveNext then
		lastPage = lastPage + 1

		if lastPage > self._totalPage then
			lastPage = self._totalPage or lastPage
		end
	else
		lastPage = lastPage - 1
		lastPage = lastPage < 1 and 1 or lastPage
	end

	if lastPage ~= self._curPage then
		self._curPage = lastPage

		self:_updateRecord()
	end
end

function ViprecordView:_initRecord()
	self._curInfos = VipModel.instance:getRecordInfo()
	self._totalPage = math.ceil(#self._curInfos / 10)
	self._totalPage = self._totalPage == 0 and 1 or self._totalPage
	self._curPage = 1

	self:_updateRecord()
end

function ViprecordView:_updateRecord()
	self._txtPage.text = self._curPage

	for i = 1, 10 do
		local info = self._curInfos[(self._curPage - 1) * 10 + i]

		if info then
			self._cellRecord[i].txtMoney.text = info.consumeMoney .. "元"

			local expireTime = tonumber(info.expireTime) / 1000

			self._cellRecord[i].txtTime.text = GameUtil.formatTimeStamp("%Y年%m月%d日失效", expireTime)

			local curTime = ServerTime.now()

			goutil.setActive(self._cellRecord[i].mark, expireTime - curTime <= 259200)
			goutil.setActive(self._cellRecord[i].go, true)
		else
			goutil.setActive(self._cellRecord[i].go, false)
		end
	end
end

return ViprecordView
