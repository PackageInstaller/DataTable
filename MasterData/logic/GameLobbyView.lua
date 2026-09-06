-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gamelobby/view/GameLobbyView.lua

module("logic.extensions.gamelobby.view.GameLobbyView", package.seeall)

local GameLobbyView = class("GameLobbyView", ActivityGrandSummaryView)

function GameLobbyView:_getSumActivityId()
	local key = self._viewPresentor.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))

		return
	end

	return data.activityId
end

function GameLobbyView:createActCell(data)
	local cellModel = goutil.findChild(self.mainGO, data.cellName)

	goutil.setActive(cellModel, false)

	if cellModel == nil then
		printError(string.format("cell预制缺失，请检查( activityId:%s, prefabName:%s, cellName:%s | export_任务面板  in  y运营-活动汇总面板-任务型.xlsx  )", self.activityId, self.mainGO.name, data.cellName))

		return nil
	end

	local go = goutil.findChild(self.activityContent, string.format("%s_%s", data.cellName, data.id))

	if go == nil then
		go = goutil.clone(cellModel, string.format("%s_%s", data.cellName, data.id))
	else
		return nil
	end

	goutil.addChildToParent(go, self.activityContent)
	GameUtil.setLocalPos(go, data.pos[1] or 0, data.pos[2] or 0)

	local cell = {}

	cell.mainGo = go
	cell.icon = goutil.findChild(cell.mainGo, "node/icon/con")
	cell.bgIcon = goutil.findChild(cell.mainGo, "node/bg")
	cell.redPoint = goutil.findChild(cell.mainGo, "node/imgRed")
	cell.newObj = goutil.findChild(cell.mainGo, "node/new")
	cell.tab = goutil.findChild(cell.mainGo, "node/tab")
	cell.txtTab = goutil.findChildTextComponent(cell.mainGo, "node/tab/txt")
	cell.txtName = goutil.findChildTextComponent(cell.mainGo, "node/txtName")
	cell.over = goutil.findChild(cell.mainGo, "node/over")
	cell.txtOver = goutil.findChildTextComponent(cell.mainGo, "node/over/txt")
	cell.time = goutil.findChild(cell.mainGo, "time")
	cell.txtTime = goutil.findChildTextComponent(cell.mainGo, "time/txtTime")
	cell.progress = goutil.findChild(cell.mainGo, "node/progress")
	cell.txtProgress = goutil.findChildTextComponent(cell.mainGo, "node/progress/txt")
	cell.slogan = goutil.findChild(cell.mainGo, "slogan")
	cell.txtSlogan = goutil.findChildTextComponent(cell.mainGo, "slogan/txtSlogan")
	cell.actProgress = goutil.findChild(cell.mainGo, "actProgress")

	if cell.actProgress then
		cell.actProgressCell = goutil.findChild(cell.mainGo, "actProgress/cell")
		cell.actProgressCells = {}
	end

	cell.btns = goutil.findChild(cell.mainGo, "btns")
	cell.data = data
	cell.id = data.id

	if cell.btns then
		for i = 1, cell.btns.transform.childCount do
			local btn = cell.btns.transform:GetChild(i - 1).gameObject

			GameUtil.addClickHandler(btn, GameUtil.handler(self.onClickActivityCell, self, cell, data))
		end
	else
		GameUtil.addClickHandler(cell.mainGo, GameUtil.handler(self.onClickActivityCell, self, cell, data))
	end

	return cell
end

return GameLobbyView
