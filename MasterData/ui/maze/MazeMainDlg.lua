-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeMainDlg.lua

local ResMaze = require("ClientData/ResMaze")
local ResRelics = require("ClientData/ResRelics")
local ResMazeConfig = require("ClientData/ResMazeConfig")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResColor = require("ClientData/ResColor")
local BtnDebuffChild = require("UI/Maze/BtnDebuffChild")
local ResMazeMisc = require("ClientData/ResMazeMisc")
local MazeControl = require("UI/Maze/MazeControl")
local MazeNode = require("UI/Maze/MazeNode")
local UserData = require("Helper/UserData")
local ICON_PATH = "Atlas/HeroAtlas/HeroCardCommonAtlas"
local ICON_PATH_GROUP = "Atlas/MazeAtlas/MazeAtlas5"
local DIFF_COLOR = {
	"WHITE",
	"ORANGEBTN",
	"RED01"
}
local strClassName = "MazeMainDlg"
local MazeMainDlg = Class(strClassName, UIControls.Window)

function MazeMainDlg:ctor(...)
	self:initUI()
end

function MazeMainDlg:initUI(...)
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.panelBg = UIControls.DragClickPanel(self, "DragBg")

	self.panelBg:setDragFunc(Slot(self.onDragFunc, self))
	self.panelBg:setClickFunc(Slot(self.onClickFunc, self))

	self.txtMazeCloseTime = UIControls.Label(self, "MainInfoPanel/FuncPanel/MazzInfoPanel/TextTime")
	self.txtMazeName = UIControls.Label(self, "MainInfoPanel/FuncPanel/MazzInfoPanel/TextName")
	self.imgDiff = UIControls.Image(self, "MainInfoPanel/FuncPanel/MazzInfoPanel/BgDifficulty")
	self.txtDiff = UIControls.Label(self, "MainInfoPanel/FuncPanel/MazzInfoPanel/TextName/TextDifficulty")
	self.btnHallow = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnHallow", "Text")

	self.btnHallow:addEventClick(self.onBtnHallowClick)

	self.txtHallowNum = UIControls.Label(self, "MainInfoPanel/FuncPanel/BtnHallow/TextNum")
	self.btnHero = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnHero", "Text")

	self.btnHero:addEventClick(self.onBtnHeroClick)

	self.btnStore = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnStore", "Text")

	self.btnStore:addEventClick(self.onBtnStoreClick)

	self.panelLvList = UIControls.Panel(self, "MainInfoPanel/LvList/Content")
	self.btnSensor = UIControls.Button(self, "MainInfoPanel/BtnSensor")

	self.btnSensor:addEventClick(self.onBtnSensorClick)
	self.btnSensor:setVisible(false)

	self.btnThink = UIControls.Button(self, "MainInfoPanel/OtherFuncPanel/BtnThink")

	self.btnThink:addEventClick(self.onBtnThinkClick)

	self.btnReborn = UIControls.Button(self, "MainInfoPanel/OtherFuncPanel/BtnReborn")

	self.btnReborn:addEventClick(self.onBtnRebornClick)
	self.btnReborn:setVisible(false)

	self.panelDebuffInfo = UIControls.Panel(self, "MainInfoPanel/DebuffInfoPanel")
	self.txtDebuffName = UIControls.Label(self, "MainInfoPanel/DebuffInfoPanel/TextName")
	self.txtDebuffDesc = UIControls.Label(self, "MainInfoPanel/DebuffInfoPanel/TextEffect")
	self.panelDebuff = UIControls.Panel(self, "MainInfoPanel/OtherFuncPanel/DebuffPanel")
	self.debuffCells = {}
	self.thinkHallows = {}

	for i = 1, 3 do
		local info = {}

		info.imgHallow = UIControls.Image(self, "MainInfoPanel/OtherFuncPanel/BtnThink/Content/Hallow" .. i)
		info.imgHallowIcon = UIControls.Image(self, "MainInfoPanel/OtherFuncPanel/BtnThink/Content/Hallow" .. i .. "/Icon")

		table.insert(self.thinkHallows, info)
	end

	self.panelHallowInfo = UIControls.Panel(self, "MainInfoPanel/HallowInfoPanel")
	self.uiHallows = {}

	for i = 1, 8 do
		local info = UIControls.Panel(self, "MainInfoPanel/HallowInfoPanel/Hallow" .. i)

		info.imgHallow = UIControls.Image(self, info.mPath .. "/BgHallow")
		info.imgHallowIcon = UIControls.Image(self, info.mPath .. "/BgHallow/Icon")
		info.imgHallowIconGroup = UIControls.Image(self, info.mPath .. "/BgHallow/IconGroup")
		info.imgHallowNone = UIControls.Image(self, info.mPath .. "/BgHallowNone")
		info.name = UIControls.Label(self, info.mPath .. "/TextHallowName")
		info.effect = UIControls.Label(self, info.mPath .. "/TextHallowEffect")

		table.insert(self.uiHallows, info)
	end

	self:initSavedNodeData()

	self.mazeControl = MazeControl

	self.mazeControl.init(self)
	self:refreshTime()
	self:show()
end

function MazeMainDlg:setMainState(state)
	self.mainState = state
end

function MazeMainDlg:refreshTime(...)
	local leftTime = CurAvatar:getMazeLeftTime()

	ClientTimerManager.RemoveSecondTickUI(self.txtMazeCloseTime)
	ClientTimerManager.AddSecondFormatTickUI(self.txtMazeCloseTime, leftTime, nil, Lang.get(30590), nil, nil)
end

function MazeMainDlg:onOpen(...)
	MazeMainDlg.super.onOpen(self)
	self:checkShowSweapAward()
end

function MazeMainDlg:show(isChangeLayer)
	self.mazeDatas = {}

	self:refreshTime()

	local maze = CurAvatar.mazeData
	local nodeId = maze.node_id + 1
	local mazeId = maze.maze_id

	self.mazeId = mazeId

	local layer = maze.layer

	self.layer = layer
	self.totalLayers = #ResMaze[maze.maze_id]
	self.curNodeId = nodeId
	self.mazeConfigData = ResMazeConfig[mazeId][1]

	local mazeName = self.mazeConfigData.maze_name
	local mazeConfigData = ResMazeConfig[mazeId][layer]
	local diffDesc = mazeConfigData.difficult_desc
	local color = ResColor[DIFF_COLOR[mazeConfigData.difficult_flag]]

	self.txtMazeName:setText(mazeName)

	if RegionUtils.isSEA() then
		self.txtDiff:setText("- " .. diffDesc)
	else
		self.txtDiff:setText("-" .. diffDesc)
	end

	self.txtMazeName:setFontColor(color)
	self.txtDiff:setFontColor(color)
	self.imgDiff:setImage("Atlas/MazeAtlas/MazeAtlas", "BgDifficulty" .. mazeConfigData.difficult_flag)

	local data = ResMaze[mazeId][layer] or {}

	if not self.nodes or isChangeLayer == true then
		if isChangeLayer then
			for _, node in ipairs(self.nodes or {}) do
				node:destroy()
			end
		end

		self.nodes = {}

		for idx, info in ipairs(data) do
			local nodeCom = self.mazeControl.getNode(idx)

			if nodeCom == nil then
				-- block empty
			else
				local node = MazeNode(self, nodeCom, idx)
				local _data = {}

				info.nodeId = idx
				_data.base = info

				node:setData(_data)
				table.insert(self.nodes, node)
			end
		end
	end

	self:refreshState()
	self:checkRelics()
	self:initDebuff(maze.pandora_relics)
	self.mazeControl.teleport(self:getCurNodePos())
end

function MazeMainDlg:changeLayer(...)
	self.mazeControl.changeLayer()
end

function MazeMainDlg:resetNewLayer(...)
	self:saveNodeData(0)
	self:initSavedNodeData()
	self.mainState:setCameraOffset(0)
end

function MazeMainDlg:isFinalLayerAndNode(idx)
	return idx == #self.nodes and CurAvatar.mazeData.layer == self.totalLayers
end

function MazeMainDlg:checkShowSweapAward(...)
	if CurAvatar.cachedMazeSweapAward then
		UIManager.getUI("mazeCleanDlg", true)
	end
end

function MazeMainDlg:initDebuff(debuffData)
	local minCount = #debuffData

	for i = 1, minCount do
		local resRelic = ResRelics[debuffData[i].id]
		local cell = self.debuffCells[i]

		if cell then
			-- block empty
		else
			cell = BtnDebuffChild(self, "MainInfoPanel/OtherFuncPanel/DebuffPanel", "System/Mazz/BtnMazzDebuff")
			cell.mClickEvent = Slot(self.onBtnDebuffClick, self)

			table.insert(self.debuffCells, cell)
		end

		cell:setVisible(true)
		cell:setData(debuffData[i].id)
	end

	for i = minCount + 1, #self.debuffCells do
		self.debuffCells[i]:setVisible(false)
	end

	local gap = 0

	if self.btnReborn:getVisible() == true then
		gap = gap + 1
	end

	if self.btnThink:getVisible() == true then
		gap = gap + 1
	end

	self.panelDebuffInfo:setPosition(-220 * gap - 21)
end

function MazeMainDlg:isNextNodeChange(idx)
	if idx + 1 == #self.nodes then
		local layerData = ResMaze[self.mazeId][self.layer]
		local nodeData = layerData[idx + 1]

		if nodeData then
			return nodeData.branchs[1].type == 11
		end
	end

	return false
end

function MazeMainDlg:getCurNodePos(...)
	local index = math.min(self.modelNode, self.curNodeId)

	if index < self.curNodeId - 1 then
		index = self.curNodeId - 1
	end

	if index == 0 then
		return MazeControl.firstPos
	end

	local pos = self.nodes[index]:getPos()

	return self.nodes[index]:getPos()
end

function MazeMainDlg:refreshState(...)
	for _, node in ipairs(self.nodes) do
		node:refreshState()
	end
end

function MazeMainDlg:setSelectNode(index, callBack)
	if self.modelNode ~= index then
		self.modelNode = index

		self:saveNodeData()
		self.mazeControl.teleportModel(self:getCurNodePos(), callBack)
	elseif not self.mazeControl.isMovingModel and callBack then
		callBack()
	end
end

function MazeMainDlg:showNodes(v)
	self.mazeControl.setVisible(v)
end

function MazeMainDlg:onBtnDebuffClick(sender)
	self.panelDebuffInfo:setVisible(true)
	self.btnSensor:setVisible(true)

	local data = sender.relicData

	self.txtDebuffDesc:setText(data.dec)
	self.txtDebuffName:setText(data.name)
end

function MazeMainDlg:onDragFunc(delta)
	local deltaX = delta.x
	local mazeState = GameFsm.getState(Const.STATE_MAIN_MAZE)

	mazeState:onDrag(deltaX)

	if self.dragExtraFunc then
		self.dragExtraFunc(deltaX)
	end
end

function MazeMainDlg:onDisableClick()
	self.clickDisable = true
end

function MazeMainDlg:onEnableClick()
	self.clickDisable = nil
end

function MazeMainDlg:onClickFunc(...)
	if self.clickDisable then
		return
	end

	local id = self.mazeControl.checkRay()

	if id > 0 and id <= #self.nodes then
		self.nodes[id]:setClick()
	end
end

function MazeMainDlg:onBtnRebornClick(...)
	UIManager.getUI("mazeRebornDlg", true)
end

function MazeMainDlg:onBtnThinkClick(...)
	local relics = CurAvatar.mazeData.relics_cache

	UIManager.getUI("mazeHallowChooseDlg", true):show(relics)
end

function MazeMainDlg:checkRelics(...)
	local ui = UIManager.tryGetUI("mazeCleanDlg")

	if ui then
		return
	end

	local relics = CurAvatar.mazeData.relics_cache
	local mazeId = CurAvatar.mazeData.maze_id
	local hallowCount = self.mazeConfigData.hallow_count or 0

	self.txtHallowNum:setText(#CurAvatar.mazeData.relics .. "/" .. hallowCount)

	if relics and #relics > 0 then
		self:setRelicMind(true, relics)

		if not CurAvatar.mazeChooseHallowLater then
			local ui = UIManager.tryGetUI("mazeHallowChooseDlg")

			if ui then
				ui:show(relics)
			else
				UIManager.getUI("mazeHallowChooseDlg", true):show(relics)
			end
		end
	else
		self:setRelicMind(false)
	end
end

function MazeMainDlg:setRelicMind(show, relics)
	if show then
		self.btnThink:setVisible(true)

		for i, data in ipairs(relics) do
			if ResRelics[data.id] then
				local resRelic = ResRelics[data.id]
				local hallow = self.thinkHallows[i]

				if resRelic.camp_id then
					hallow.imgHallow:setImage(ICON_PATH_GROUP, "BgBuffGroup" .. resRelic.camp_id)
				else
					hallow.imgHallow:setImage(ICON_PATH_GROUP, "BgBuff")
				end

				hallow.imgHallowIcon:setImage(resRelic.relic_icon_path, resRelic.relic_icon_name)
			end
		end
	else
		self.btnThink:setVisible(false)
	end
end

function MazeMainDlg:lookCenter(...)
	local mazeState = GameFsm.getState(Const.STATE_MAIN_MAZE)

	mazeState:setCenterPos(self:getCurNodePos())
end

function MazeMainDlg:getDebuffFlyObj(...)
	return self.panelDebuff
end

function MazeMainDlg:rfreshHallowInfo(...)
	local relics = CurAvatar.mazeData.relics
	local mazeId = CurAvatar.mazeData.maze_id
	local hallowCount = self.mazeConfigData.hallow_count or 0

	for i = hallowCount + 1, #self.uiHallows do
		self.uiHallows[i]:setVisible(false)
	end

	local count = 0

	if relics then
		for i, data in ipairs(relics) do
			count = i

			if ResRelics[data.id] then
				local info = ResRelics[data.id]
				local hallowCell = self.uiHallows[i]

				self.uiHallows[i].imgHallowIcon:setImage(info.relic_icon_path, info.relic_icon_name)

				if info.camp_id then
					hallowCell.imgHallowIconGroup:setVisible(true)
					hallowCell.imgHallowIconGroup:setImage(ICON_PATH, "IconGroup0" .. info.camp_id)
				else
					hallowCell.imgHallowIconGroup:setVisible(false)
				end

				hallowCell.name:setText(info.name)
				hallowCell.name:setFontColor(ResColor.WHITE)
				hallowCell.effect:setText(info.dec)
			end
		end
	end

	if count < #self.uiHallows then
		for i = count + 1, hallowCount do
			self.uiHallows[i].name:setText(Lang.get(519))
			self.uiHallows[i].name:setFontColor(ResColor.GREYLIGHT)
			self.uiHallows[i].effect:setText("")
		end
	end
end

function MazeMainDlg:getBestHeroId(...)
	if self.showHeroId then
		return self.showHeroId, self.showBaseId
	end

	self.showHeroId = 14101
	self.showBaseId = 14101

	local heros = {}

	if CurAvatar then
		local heroGids = CurAvatar:getNowFormation()

		for gid, pos in pairs(heroGids) do
			local hero = CurAvatar.heroDic[gid]

			if hero then
				table.insert(heros, hero)
			end
		end

		if #heros == 0 then
			for gid, hero in pairs(CurAvatar.heroDic) do
				table.insert(heros, hero)
			end
		end

		local function sortHero(heroA, heroB)
			if heroA.star ~= heroB.star then
				return heroA.star > heroB.star
			elseif heroA.level ~= heroB.level then
				return heroA.level > heroB.level
			end

			return heroA.id < heroB.id
		end

		table.sort(heros, sortHero)
	end

	if #heros > 0 then
		self.showHeroId = heros[1]:getShowModelId()
		self.showBaseId = heros[1]:getShowBaseModelId()
	end

	self:saveNodeData()

	return self.showHeroId, self.showBaseId
end

function MazeMainDlg:initSavedNodeData(...)
	local nodeData = UserData.loadCommonData(CurAvatar.uid .. Const.MAZE_CHALLENGED_NODE)

	if nodeData and nodeData ~= "" then
		local data = utils.splitString(nodeData, ",")

		self.modelNode = tonumber(data[1]) or 0
		self.showHeroId = tonumber(data[2])
		self.showBaseId = tonumber(data[3])
	else
		self.modelNode = 0
	end
end

function MazeMainDlg:saveNodeData(nodeId)
	UserData.saveCommonData(CurAvatar.uid .. Const.MAZE_CHALLENGED_NODE, (nodeId or self.modelNode) .. "," .. self.showHeroId .. "," .. self.showBaseId)
end

function MazeMainDlg:onBtnCloseClick(...)
	GameFsm.getState(Const.STATE_MAIN):enterDefaultMainState()
	self:setVisible(false)
end

function MazeMainDlg:onBtnTipsClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_MAZE)
end

function MazeMainDlg:onBtnSensorClick(...)
	self.btnSensor:setVisible(false)
	self.panelHallowInfo:setVisible(false)
	self.panelDebuffInfo:setVisible(false)
end

function MazeMainDlg:onBtnHallowClick(...)
	local time = ClientUtils.getServerTime() - ClientUtils.openZoneTime
	local day = math.floor(time / 3600 / 24) + 1

	self.panelHallowInfo:setVisible(true)
	self.btnSensor:setVisible(true)
	self:rfreshHallowInfo()
end

function MazeMainDlg:onBtnHeroClick()
	UIManager.getUI("mazeHeroCheckDlg", true)
end

function MazeMainDlg:onBtnStoreClick(...)
	UIManager.createAndFunc("mallDlg", "showShop", Const.JUMPSHOPTYPE_MAZESHOP)
end

function MazeMainDlg:destroy(...)
	self.mazeControl.preDestroy()

	for _, node in ipairs(self.nodes) do
		node:destroy()
	end

	self.nodes = nil

	MazeMainDlg.super.destroy(self)
end

return MazeMainDlg
