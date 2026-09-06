-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/HexagramGameCopyView.lua

module("logic.extensions.yirenpozhen.view.HexagramGameCopyView", package.seeall)

local HexagramGameCopyView = class("HexagramGameCopyView", ViewComponent)
local ROTATE_TIME = 0.3
local NUM_PERLAYER = 4
local CELL_RADIUS = {
	65,
	140,
	210
}
local layerMaxNum = 3

function HexagramGameCopyView:ctor()
	HexagramGameCopyView.super.ctor(self)

	self._cells = {}
end

function HexagramGameCopyView:buildUI()
	HexagramGameCopyView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._layers = {}

	for i = 1, layerMaxNum do
		table.insert(self._layers, self:getGo("layer_" .. i))
	end

	self._btnLeft = self:getBtn("btnLeft")
	self._btnRight = self:getBtn("btnRight")
	self._btnChange = self:getBtn("btnChange")
	self._btnReset = self:getBtn("btnReset")
	self._btnHelp = self:getBtn("btnHelp")
	self._txtStep = self:getTxt("ui/txtStep")
	self._txtRecord = self:getTxt("ui/txtRecord")
	self._pointer = {}
end

function HexagramGameCopyView:bindEvents()
	HexagramGameCopyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._failClose, self)
	self._btnLeft:AddClickListener(self._clockWise, self)
	self._btnRight:AddClickListener(self._anticlockWise, self)
	self._btnChange:AddClickListener(self._change, self)
	self._btnReset:AddClickListener(self._resetAll, self)
	self._btnHelp:AddClickListener(self._clickHelp, self)
end

function HexagramGameCopyView:unbindEvents()
	HexagramGameCopyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnHelp:RemoveClickListener()
end

function HexagramGameCopyView:destroyUI()
	HexagramGameCopyView.super.destroyUI(self)
end

function HexagramGameCopyView:onEnter()
	HexagramGameCopyView.super.onEnter(self)

	local parmas = self:getOpenParam()
	local gamePlanId = checknumber(parmas[1])

	self._finishCallBack = parmas[2]
	self._changing = false
	self._stepNum = 0
	self._gameCfg = YirenPozhenConfig.instance:getHexagramCfg(gamePlanId)

	for k, cfg in pairs(self._gameCfg) do
		cfg.size = #cfg.initState
		cfg.rotateAngle = 360 / checknumber(cfg.size)
	end

	self:_generateAll()
	self:_doResetAll()
	self:_refreshStep()
end

function HexagramGameCopyView:onEnterFinished()
	HexagramGameCopyView.super.onEnterFinished(self)
end

function HexagramGameCopyView:onExit()
	HexagramGameCopyView.super.onExit(self)

	for k, v in ipairs(self._cells) do
		for i, o in pairs(v) do
			goutil.destroy(o.obj)
		end

		table.clear(v)
	end

	table.clear(self._cells)

	if self._tweenRotate then
		self._tweenRotate:Kill(false)
	end

	if self._tweenChange then
		self._tweenChange:Kill(false)
	end
end

function HexagramGameCopyView:onExitFinished()
	HexagramGameCopyView.super.onExitFinished(self)
end

function HexagramGameCopyView:_resetAll()
	if self._changing == false then
		self._changing = true

		local dataKey = "HexagramPopUpResetWindow"

		if not GameUtil.getUserDayData(dataKey) then
			TipsFacade.instance:openPopupWindowWithTog("提示", langPara("你将重置本轮游戏至初始\n状态，请确认是否继续。"), function()
				self:_doResetAll()
			end, nil, function()
				GameUtil.saveUserDayData(dataKey, true)
			end, "确定", "取消", "勾选后不再出现此弹窗", UnityEngine.TextAnchor.MiddleCenter)
		else
			self:_doResetAll()
		end

		self._changing = false
	end
end

function HexagramGameCopyView:_doResetAll()
	for layer = 1, self._layerNum do
		GameUtil.setLocalRotation(self._layers[layer], 0, 0, 0)

		local layerCfg = self._gameCfg[layer]

		for i, v in ipairs(self._cells[layer]) do
			local cellData = {}

			cellData.size = layerCfg.size
			cellData.state = layerCfg.initState[i]
			cellData.order = i
			cellData.radius = CELL_RADIUS[layer]
			v.data = cellData

			v.cell:initCell(v.data)
		end
	end

	for i = 1, self._layerNum do
		self._pointer[i] = self._gameCfg[i].size / NUM_PERLAYER
	end

	self._stepNum = 0

	self:_refreshStep()
end

function HexagramGameCopyView:_generateAll()
	local layer = 1

	for k, v in pairs(self._gameCfg) do
		local layerCfg = self._gameCfg[layer]

		self._cells[layer] = {}

		if layerCfg then
			local states = layerCfg.initState
			local size = layerCfg.size

			for i = 1, size do
				local cellData = {}

				cellData.size = size
				cellData.state = states[i]
				cellData.order = i
				cellData.radius = CELL_RADIUS[layer]

				local hexagramCell
				local cellObj = self:getResInstance("ui/views/yirenpozhen/hexagramcell.prefab")

				if cellObj then
					goutil.addChildToParent(cellObj, self._layers[layer])

					hexagramCell = Framework.LuaComponentContainer.Add(cellObj, HexagramCell)

					hexagramCell:initCell(cellData)
				end

				local factor1 = i / size
				local angle = math.pi * 2 * factor1
				local x = math.cos(angle) * cellData.radius
				local y = math.sin(angle) * cellData.radius

				GameUtil.setLocalPos(cellObj, x, y, 0)

				local angle360 = factor1 * 360 + 90

				GameUtil.setLocalRotation(cellObj, 0, 0, angle360)
				table.insert(self._cells[layer], {
					obj = cellObj,
					data = cellData,
					cell = hexagramCell
				})
			end
		end

		layer = layer + 1
	end

	self._layerNum = layer - 1

	table.clear(self._pointer)

	for i = 1, self._layerNum do
		table.insert(self._pointer, self._gameCfg[i].size / NUM_PERLAYER)
	end
end

function HexagramGameCopyView:_clockWise()
	AudioPlayerEx.instance:playEffect(30106)

	if self._changing == false then
		self._changing = true

		local preAngleList = {}

		for layer = 1, self._layerNum do
			local x, y, z = GameUtil.getLocalRotation(self._layers[layer])

			preAngleList[layer] = z
		end

		self._tweenRotate = TweenUtil.ValueTo(0, 1, ROTATE_TIME, function(val)
			for layer = 1, self._layerNum do
				GameUtil.setLocalRotation(self._layers[layer], 0, 0, preAngleList[layer] + val * self._gameCfg[layer].rotateAngle)
			end
		end, function()
			for layer = 1, self._layerNum do
				self._pointer[layer] = self._pointer[layer] - 1

				if self._pointer[layer] < 1 then
					self._pointer[layer] = self._gameCfg[layer].size
				end
			end

			self._changing = false
			self._stepNum = self._stepNum + 1

			self:_refreshStep()
			self:_checkCompelete()
		end, self, DG.Tweening.Ease.Linear)
	end
end

function HexagramGameCopyView:_anticlockWise()
	AudioPlayerEx.instance:playEffect(30106)

	if self._changing == false then
		self._changing = true

		local preAngleList = {}

		for layer = 1, self._layerNum do
			local x, y, z = GameUtil.getLocalRotation(self._layers[layer])

			preAngleList[layer] = z
		end

		self._tweenRotate = TweenUtil.ValueTo(0, 1, ROTATE_TIME, function(val)
			for layer = 1, self._layerNum do
				GameUtil.setLocalRotation(self._layers[layer], 0, 0, preAngleList[layer] + val * -self._gameCfg[layer].rotateAngle)
			end
		end, function()
			for layer = 1, self._layerNum do
				local size = self._gameCfg[layer].size

				self._pointer[layer] = self._pointer[layer] + 1

				if size < self._pointer[layer] then
					self._pointer[layer] = 1
				end
			end

			self._changing = false
			self._stepNum = self._stepNum + 1

			self:_refreshStep()
			self:_checkCompelete()
		end, self, DG.Tweening.Ease.Linear)
	end
end

function HexagramGameCopyView:_change()
	AudioPlayerEx.instance:playEffect(30106)

	if self._changing == false then
		self._changing = true

		local temp1 = self._cells[self._layerNum][self._pointer[self._layerNum]]
		local tempData = {
			obj = temp1.obj,
			data = temp1.data,
			cell = temp1.cell
		}

		for i = self._layerNum, 2, -1 do
			local temp = self._cells[i - 1][self._pointer[i - 1]]

			self._cells[i][self._pointer[i]] = {
				obj = temp.obj,
				data = temp.data,
				cell = temp.cell
			}

			goutil.addChildToParent(self._cells[i][self._pointer[i]].obj, self._layers[i])
		end

		self._cells[1][self._pointer[1]] = {
			obj = tempData.obj,
			data = tempData.data,
			cell = tempData.cell
		}

		goutil.addChildToParent(temp1.obj, self._layers[1])

		local preLen = {}

		for i = 2, self._layerNum do
			preLen[i] = CELL_RADIUS[i - 1]
		end

		preLen[1] = CELL_RADIUS[self._layerNum]

		local posList = {}

		for i = 1, self._layerNum do
			local objTransform = self._cells[i][self._pointer[i]].obj.transform
			local x, y, z = Framework.TransformUtil.GetLocalPos(objTransform, 0, 0, 0)
			local rx, ry, rz = Framework.TransformUtil.GetLocalRotation(objTransform, 0, 0, 0)
			local factor = self._pointer[i] / self._gameCfg[i].size

			posList[i] = {
				x = math.cos(factor * 2 * math.pi) * preLen[i],
				y = math.sin(factor * 2 * math.pi) * preLen[i],
				z = z,
				targetX = math.cos(factor * 2 * math.pi) * CELL_RADIUS[i],
				targetY = math.sin(factor * 2 * math.pi) * CELL_RADIUS[i],
				rz = rz,
				targetRz = factor * 360 + 90
			}
		end

		self._tweenChange = TweenUtil.ValueTo(0, 1, ROTATE_TIME, function(val)
			for i = 1, self._layerNum do
				local dx = (posList[i].targetX - posList[i].x) * val
				local dy = (posList[i].targetY - posList[i].y) * val
				local cellObj = self._cells[i][self._pointer[i]].obj

				GameUtil.setLocalPos(cellObj, posList[i].x + dx, posList[i].y + dy, posList[i].z)
				GameUtil.setLocalRotation(cellObj, 0, 0, posList[i].targetRz)
			end
		end, function()
			self._changing = false
			self._stepNum = self._stepNum + 1

			self:_refreshStep()
			self:_checkCompelete()
		end, self, DG.Tweening.Ease.Linear)
	end
end

function HexagramGameCopyView:_checkCompelete()
	for layer = 1, self._layerNum do
		print("--------------layer" .. layer .. ":" .. self._pointer[layer])
	end

	for layer = 1, self._layerNum do
		local state = self._cells[layer][1].data.state

		for i, v in ipairs(self._cells[layer]) do
			if v.data.state ~= state then
				return
			end
		end
	end

	self:_compelete()
end

function HexagramGameCopyView:_compelete()
	TipsFacade.instance:openPopupWindow("恭喜你成功通关", langPara("本次通关所用步数：%s", self._stepNum), function()
		local info = {}

		info.isPass = true
		info.gameScore = self._stepNum

		GameUtil.callBack(self._finishCallBack, info)
		self:close()
	end, function()
		self:_resetAll()
	end, "确认", "重新开始", UnityEngine.TextAnchor.MiddleCenter)
end

function HexagramGameCopyView:_refreshStep()
	self._txtStep.text = langPara("当前步数：%s", self._stepNum)
end

function HexagramGameCopyView:_clickHelp()
	local ruleCo = RulesConfig.instance:getRuleCo("HexagramGameRule_Copy")
	local title = tostring((not ruleCo.title or nil) and 0)

	if not title or title == "0" or #title == 0 then
		title = lang("tip")
	end

	TipsFacade.instance:openTipWindowNoX(title, ruleCo.rules)
end

function HexagramGameCopyView:_failClose()
	local info = {}

	info.isPass = false
	info.gameScore = 0

	GameUtil.callBack(self._finishCallBack, info)
	self:close()
end

return HexagramGameCopyView
