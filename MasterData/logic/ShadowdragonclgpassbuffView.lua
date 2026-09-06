-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclgpassbuffView.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclgpassbuffView", package.seeall)

local ShadowdragonclgpassbuffView = class("ShadowdragonclgpassbuffView", ViewComponent)

function ShadowdragonclgpassbuffView:ctor()
	ShadowdragonclgpassbuffView.super.ctor(self)
end

function ShadowdragonclgpassbuffView:unbindEvents()
	ShadowdragonclgpassbuffView.super.unbindEvents(self)
end

function ShadowdragonclgpassbuffView:bindEvents()
	ShadowdragonclgpassbuffView.super.bindEvents(self)
end

function ShadowdragonclgpassbuffView:buildUI()
	ShadowdragonclgpassbuffView.super.buildUI(self)

	self._txtDesc = self:getTxt("txtDesc")

	self:_buildBuffCells()
end

function ShadowdragonclgpassbuffView:_buildBuffCells()
	self._cellsGo = {}

	for i = 1, 2 do
		local go = self:getGo("cell" .. i)

		table.insert(self._cellsGo, go)
	end
end

function ShadowdragonclgpassbuffView:onExit()
	ShadowdragonclgpassbuffView.super.onExit(self)
end

function ShadowdragonclgpassbuffView:onEnter()
	ShadowdragonclgpassbuffView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._selectBuffId = params[3] or 0
	self._callBack = params[4]

	self:_updateUI()
end

function ShadowdragonclgpassbuffView:_updateUI()
	local buffCfgs = ShadowdragonclgConfig.instance:getFuturePassBuffCfgs(self._activityId, self._stageId)

	self:_updateCell(self._cellsGo[1], buffCfgs[1])
	self:_updateCell(self._cellsGo[2], buffCfgs[2])

	self._txtDesc.text = "回响x1"
end

function ShadowdragonclgpassbuffView:_updateCell(go, data)
	local btn = Framework.ButtonAdapter.GetFrom(go.gameObject, "btn")
	local txtDesc = goutil.findChildTextComponent(go.gameObject, "txtDesc")
	local selectGo = goutil.findChild(go.gameObject, "select")

	txtDesc.text = data.desc

	goutil.setActive(selectGo, self._selectBuffId == data.buffId)
	btn:AddClickListener(function()
		if not self:_checkEnough() then
			FloatWordMgr.instance:show("消耗材料不足，无法选择")

			return
		end

		self._selectBuffId = data.buffId

		self._callBack(data.buffId)
		self:close()
	end)
end

function ShadowdragonclgpassbuffView:_checkEnough()
	local info = ShadowdragonclgModel.instance:getInfo(self._activityId)
	local count = 0
	local useCount = 0

	for i, v in ipairs(info.nowStageList) do
		if v.selectBuffId == ShadowdragonclgController.PassFutureStageType.Pass then
			count = count + 1
		end
	end

	for i, v in ipairs(info.futurePassStageList) do
		if v.param > 0 then
			local stageCfg = ShadowdragonclgConfig.instance:getFuturePassStageCfg(self._activityId, v.stageId)

			if stageCfg.type == ShadowdragonclgController.PassFutureStageType.Pass then
				useCount = useCount + 1
			end
		end
	end

	return useCount < count
end

return ShadowdragonclgpassbuffView
