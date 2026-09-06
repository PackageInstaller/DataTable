-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclgbuffView.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclgbuffView", package.seeall)

local ShadowdragonclgbuffView = class("ShadowdragonclgbuffView", ViewComponent)

function ShadowdragonclgbuffView:ctor()
	ShadowdragonclgbuffView.super.ctor(self)
end

function ShadowdragonclgbuffView:unbindEvents()
	ShadowdragonclgbuffView.super.unbindEvents(self)
end

function ShadowdragonclgbuffView:bindEvents()
	ShadowdragonclgbuffView.super.bindEvents(self)
end

function ShadowdragonclgbuffView:buildUI()
	ShadowdragonclgbuffView.super.buildUI(self)
	self:_buildBuffCells()
end

function ShadowdragonclgbuffView:_buildBuffCells()
	self._cellsGo = {}

	for i = 1, 3 do
		local go = self:getGo("cell" .. i)

		table.insert(self._cellsGo, go)
	end
end

function ShadowdragonclgbuffView:onExit()
	ShadowdragonclgbuffView.super.onExit(self)
end

function ShadowdragonclgbuffView:onEnter()
	ShadowdragonclgbuffView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._callBack = params[3]
	self._lastBuffId = ShadowdragonclgModel.instance:getNowStageSelectBuffId(self._activityId, self._stageId)
	self._selectBuffId = self._lastBuffId or 0

	if not self._callBack and self._selectBuffId <= 0 then
		self._selectBuffId = -1
	end

	self:_updateUI()
end

function ShadowdragonclgbuffView:_onClickbtnSure()
	if self._selectBuffId < 0 then
		FloatWordMgr.instance:show("请选择buff")

		return
	end

	if self._callBack then
		self._callBack(self._selectBuffId)
	else
		if self._selectBuffId ~= self._lastBuffId then
			ShadowDragonClgAgent.instance:sendPM_ShadowDragonClgSelectBuffReq(self._activityId, self._stageId, self._selectBuffId)
		end

		local fmtMo = ShadowdragonclgModel.instance:getFmtMo()

		fmtMo:initParams(self._activityId, ShadowdragonclgController.FloorType.Now, self._stageId)
		CustomFmtController.instance:showMissionView(fmtMo)
	end
end

function ShadowdragonclgbuffView:_updateUI()
	local buffCfgs = ShadowdragonclgConfig.instance:getBuffCfgs(self._activityId, self._stageId)

	self:_updateCell(self._cellsGo[1], buffCfgs[1])
	self:_updateCell(self._cellsGo[2])
	self:_updateCell(self._cellsGo[3], buffCfgs[2])
end

function ShadowdragonclgbuffView:_updateCell(go, data)
	local btn = Framework.ButtonAdapter.GetFrom(go.gameObject, "btn")
	local txtDesc = goutil.findChildTextComponent(go.gameObject, "txtDesc")
	local selectGo = goutil.findChild(go.gameObject, "select")

	if data then
		txtDesc.text = data.desc

		goutil.setActive(selectGo, self._selectBuffId == data.buffId)
	else
		goutil.setActive(selectGo, self._selectBuffId == 0)
	end

	btn:AddClickListener(function()
		self._selectBuffId = not data and 0 or data.buffId

		self:_onClickbtnSure()
		self:close()
	end)
end

return ShadowdragonclgbuffView
