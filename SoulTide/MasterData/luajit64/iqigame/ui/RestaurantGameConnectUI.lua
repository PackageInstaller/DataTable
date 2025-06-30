-- chunkname: @IQIGame\\UI\\RestaurantGameConnectUI.lua

local RestaurantGameConnectUI = {
	lockClick = false,
	showCD = 0,
	isTimeOut = false,
	countDown = 0,
	startGame = false,
	fruitGameItemCells = {},
	mapBoard = {}
}

RestaurantGameConnectUI = Base:Extend("RestaurantGameConnectUI", "IQIGame.Onigao.UI.RestaurantGameConnectUI", RestaurantGameConnectUI)

require("IQIGame.UIExternalApi.RestaurantGameConnectUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FruitGameItemCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.FruitCleanGame.FruitGameItemCell")
local ROFruitUIPathData = require("IQIGame.Module.CommonActivity.RestaurantOperation.ROFruitCleanGame.ROFruitUIPathData")

function RestaurantGameConnectUI:OnInit()
	function self.DelegateBtnSelectLevel()
		self:OnBtnSelectLevel()
	end

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateBtnRank()
		self:OnBtnRank()
	end

	function self.DelegateBtnRestart()
		self:OnBtnRestart()
	end

	function self.DelegateBtnStartGame()
		self:OnBtnStartGame()
	end

	function self.DelegateUpdateFruitClean()
		self:OnUpdateFruitCleanGame()
	end

	function self.DelegateUpdateFruitCleanRank()
		self:OnUpdateFruitCleanRank()
	end

	self.FruitMould:SetActive(false)

	self.fruitGameItemCellPool = UIObjectPool.New(80, function()
		local fruitCell = FruitGameItemCell.New(UnityEngine.Object.Instantiate(self.FruitMould))

		function fruitCell.clickCallBack(cell)
			self:OnSelectFruit(cell)
		end

		return fruitCell
	end, function(cell)
		cell:Dispose()
	end)
end

function RestaurantGameConnectUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantGameConnectUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantGameConnectUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantGameConnectUI:GetBGM(userData)
	return nil
end

function RestaurantGameConnectUI:OnOpen(userData)
	ROFruitCleanGameModule.GetFruitCleanGameRanking()
	self:DefaultState()
	self:UpdateView()
end

function RestaurantGameConnectUI:OnClose(userData)
	return
end

function RestaurantGameConnectUI:OnAddListeners()
	self.BtnSelectLevel:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelectLevel)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.BtnRank:GetComponent("Button").onClick:AddListener(self.DelegateBtnRank)
	self.BtnRestart:GetComponent("Button").onClick:AddListener(self.DelegateBtnRestart)
	self.BtnStartGame:GetComponent("Button").onClick:AddListener(self.DelegateBtnStartGame)
	EventDispatcher.AddEventListener(EventID.ROUpdateFruitCleanGameEvent, self.DelegateUpdateFruitClean)
	EventDispatcher.AddEventListener(EventID.ROUpdateFruitCleanGameRankEvent, self.DelegateUpdateFruitCleanRank)
end

function RestaurantGameConnectUI:OnRemoveListeners()
	self.BtnSelectLevel:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelectLevel)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.BtnRank:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRank)
	self.BtnRestart:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRestart)
	self.BtnStartGame:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnStartGame)
	EventDispatcher.RemoveEventListener(EventID.ROUpdateFruitCleanGameEvent, self.DelegateUpdateFruitClean)
	EventDispatcher.RemoveEventListener(EventID.ROUpdateFruitCleanGameRankEvent, self.DelegateUpdateFruitCleanRank)
end

function RestaurantGameConnectUI:OnPause()
	return
end

function RestaurantGameConnectUI:OnResume()
	return
end

function RestaurantGameConnectUI:OnCover()
	return
end

function RestaurantGameConnectUI:OnReveal()
	return
end

function RestaurantGameConnectUI:OnRefocus(userData)
	return
end

function RestaurantGameConnectUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.startGame then
		local now = PlayerModule.GetServerTime()
		local passTime = now - ROFruitCleanGameModule.roFruitCleanGameData.startTime
		local useTime = math.ceil(passTime)

		UGUIUtil.SetText(self.TextUseTime, useTime)

		local cdPass = now - self.resetTime

		self.showCD = self.showCD - cdPass
		self.ImgTimerCD:GetComponent("Image").fillAmount = self.showCD / self.countDown

		UGUIUtil.SetText(self.TextTimerCD, string.format("%.2f", self.showCD / 1000))

		if self.showCD <= 0 then
			self.startGame = false
			self.isTimeOut = true

			self:CheckResult()
			log("GameEnd")
			UGUIUtil.SetText(self.TextTimerCD, 0)
		end
	end
end

function RestaurantGameConnectUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantGameConnectUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantGameConnectUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantGameConnectUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.fruitGameItemCells) do
		self.fruitGameItemCellPool:Release(v)
	end

	self.fruitGameItemCells = {}

	self.fruitGameItemCellPool:Dispose()
end

function RestaurantGameConnectUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function RestaurantGameConnectUI:DefaultState()
	self.lockClick = false
	self.isTimeOut = false

	self.BtnStartGame:SetActive(true)
	self.BtnRestart:SetActive(false)

	self.countDown = CfgRestaurantOperationFruitCleanControlTable[ROFruitCleanGameModule.roFruitCleanGameData.cid].Countdown * 1000
	self.showCD = self.countDown

	UGUIUtil.SetText(self.TextTimerCD, "")

	self.ImgTimerCD:GetComponent("Image").fillAmount = 1

	if self.firstFruitCell then
		self.firstFruitCell:SetSelect(false)
	end

	self.firstFruitCell = nil

	if self.secondFruitCell then
		self.secondFruitCell:SetSelect(false)
	end

	self.secondFruitCell = nil
	self.startGame = false
	self.isTimeOut = false
end

function RestaurantGameConnectUI:OnBtnStartGame()
	ROFruitCleanGameModule.roFruitCleanGameData.startTime = PlayerModule.GetServerTime()
	self.resetTime = PlayerModule.GetServerTime()

	self.BtnStartGame:SetActive(false)
	self.BtnRestart:SetActive(true)

	self.startGame = true
end

function RestaurantGameConnectUI:OnBtnRestart()
	ROFruitCleanGameModule.CreateNewLevel()
	self:DefaultState()
	self:UpdateView()
end

function RestaurantGameConnectUI:OnBtnSelectLevel()
	UIModule.Open(Constant.UIControllerName.RestaurantGameFruitCleanSelectLevelUI, Constant.UILayer.UI)
end

function RestaurantGameConnectUI:OnBtnRank()
	UIModule.Open(Constant.UIControllerName.RestaurantGameConnectRankUI, Constant.UILayer.UI)
end

function RestaurantGameConnectUI:OnUpdateFruitCleanGame()
	self:DefaultState()
	self:UpdateView()
end

function RestaurantGameConnectUI:OnUpdateFruitCleanRank()
	local rank = ROFruitCleanGameModule.myRanking or 0

	UGUIUtil.SetText(self.TextRank, RestaurantGameConnectUIApi:GetString("TextRankIndex", rank))
	self.RankTag:SetActive(rank > ROFruitCleanGameModule.fruitCleanGameRankMaxNum)
end

function RestaurantGameConnectUI:UpdateView()
	UGUIUtil.SetText(self.TextLevel, ROFruitCleanGameModule.roFruitCleanGameData:GetCfgData().Level)
	UGUIUtil.SetText(self.TextUseTotalTime, ROFruitCleanGameModule.GetPassTotalTime())
	UGUIUtil.SetText(self.TextUseTime, "0")
	self:OnUpdateFruitCleanRank()

	for i, v in pairs(self.fruitGameItemCells) do
		self.fruitGameItemCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.fruitGameItemCells = {}
	self.mapBoard = {}

	for i = 1, #ROFruitCleanGameModule.roFruitCleanGameData.fruits do
		local data = ROFruitCleanGameModule.roFruitCleanGameData.fruits[i]

		data:SetPos(i)

		local render = self.fruitGameItemCellPool:Obtain()

		render.View:SetActive(true)
		render.View.transform:SetParent(self.FruitContent.transform, false)
		render:SetData(data)
		table.insert(self.fruitGameItemCells, render)

		local x, y = data:GetX_Y()

		self.mapBoard[x] = self.mapBoard[x] or {}

		if data.cid > 0 then
			self.mapBoard[x][y] = data.cid
		else
			self.mapBoard[x][y] = 0
		end
	end
end

function RestaurantGameConnectUI:OnSelectFruit(cell)
	if not self.startGame then
		return
	end

	if self.lockClick then
		return
	end

	local x, y = cell.fruitData:GetX_Y()

	log("选中了水果.cid = " .. cell.fruitData.cid .. " pos = " .. cell.fruitData.pos .. " x = " .. x .. " y = " .. y)

	if self.firstFruitCell and self.firstFruitCell == cell then
		cell:SetSelect(false)

		self.firstFruitCell = nil

		return
	end

	if self.secondFruitCell and self.secondFruitCell == cell then
		cell:SetSelect(false)

		self.secondFruitCell = nil

		return
	end

	if self.firstFruitCell == nil then
		self.firstFruitCell = cell

		self.firstFruitCell:SetSelect(true)
	elseif self.secondFruitCell == nil then
		self.secondFruitCell = cell

		self.secondFruitCell:SetSelect(true)
	end

	if self.firstFruitCell and self.secondFruitCell then
		local cleanSuccess = false

		self.lockClick = true

		if self.firstFruitCell.fruitData.cid == self.secondFruitCell.fruitData.cid then
			local x1, y1 = self.firstFruitCell.fruitData.x, self.firstFruitCell.fruitData.y
			local x2, y2 = self.secondFruitCell.fruitData.x, self.secondFruitCell.fruitData.y
			local top, path = self:FindConnectPath(x1, y1, x2, y2)

			cleanSuccess = top

			for i, v in pairs(path) do
				log("路径 = " .. v.x .. " " .. v.y)
			end

			log("有路径 " .. tostring(cleanSuccess))

			if cleanSuccess then
				self.firstFruitCell:PlayEffect(true)
				self.secondFruitCell:PlayEffect(true)

				local pathTab, fruitItemCells = self:PlayLine(path, {
					x = x1,
					y = y1
				}, {
					x = x2,
					y = y2
				})
				local time = Timer.New(function()
					for i, v in pairs(fruitItemCells) do
						v:ShowLine({})
					end

					self.mapBoard[x1][y1] = 0
					self.mapBoard[x2][y2] = 0
					self.firstFruitCell.fruitData.isClean = true

					self.firstFruitCell:CleanFruit()
					self.firstFruitCell:SetSelect(false)

					self.firstFruitCell = nil
					self.secondFruitCell.fruitData.isClean = true

					self.secondFruitCell:CleanFruit()
					self.secondFruitCell:SetSelect(false)

					self.secondFruitCell = nil
					self.lockClick = false

					self:CheckResult()
				end, 0.5)

				time:Start()

				self.resetTime = PlayerModule.GetServerTime()
				self.showCD = self.countDown
			end
		end

		if not cleanSuccess then
			self.firstFruitCell:PlayEffect(false)
			self.secondFruitCell:PlayEffect(false)

			local time = Timer.New(function()
				self.firstFruitCell:SetSelect(false)
				self.secondFruitCell:SetSelect(false)

				self.firstFruitCell = nil
				self.secondFruitCell = nil
				self.lockClick = false
			end, 1)

			time:Start()
		end
	end
end

function RestaurantGameConnectUI:GetFruitCell(x, y)
	for i, v in pairs(self.fruitGameItemCells) do
		if v.fruitData.x == x and v.fruitData.y == y then
			return v
		end
	end

	return nil
end

function RestaurantGameConnectUI:PlayLine(paths, startPos, endPos)
	local tempPath = {}
	local fruitItemCells = {}
	local lastPos = startPos

	for i = 1, #paths do
		local checkPath = paths[i]
		local nextPath = paths[i + 1]

		if nextPath == nil then
			nextPath = endPos
		end

		tempPath[#tempPath + 1] = self:RefreshPathDir(lastPos, checkPath, nextPath)
		lastPos = checkPath
	end

	for i = 1, #tempPath do
		local pa = tempPath[i]
		local cell = self:GetFruitCell(pa.x, pa.y)

		cell:ShowLine(pa.dir)
		table.insert(fruitItemCells, cell)
	end

	return tempPath, fruitItemCells
end

function RestaurantGameConnectUI:RefreshPathDir(lastPos, pathData, nextPos)
	local newPas = ROFruitUIPathData.New(pathData.x, pathData.y, {})
	local dir1, dir2
	local dirTab = {}

	if pathData.x > lastPos.x then
		dir1 = 1
	elseif pathData.x < lastPos.x then
		dir1 = 2
	end

	if pathData.y > lastPos.y then
		dir1 = 3
	elseif pathData.y < lastPos.y then
		dir1 = 4
	end

	dirTab[#dirTab + 1] = dir1

	if pathData.x > nextPos.x then
		dir2 = 1
	elseif pathData.x < nextPos.x then
		dir2 = 2
	end

	if pathData.y > nextPos.y then
		dir2 = 3
	elseif pathData.y < nextPos.y then
		dir2 = 4
	end

	dirTab[#dirTab + 1] = dir2
	newPas.dir = dirTab

	return newPas
end

function RestaurantGameConnectUI:FindConnectPath(startX, startY, endX, endY)
	local result, path = self:StraightConnection(startX, startY, endX, endY)

	if result then
		return result, path
	end

	result, path = self:OneTurnConnection(startX, startY, endX, endY)

	if result then
		return result, path
	end

	result, path = self:TwoTurnConnection(startX, startY, endX, endY)

	if result then
		return result, path
	end

	return false, {}
end

function RestaurantGameConnectUI:GetMapSize()
	return #self.mapBoard, #self.mapBoard[1]
end

function RestaurantGameConnectUI:TwoTurnConnection(startX, startY, endX, endY)
	local emptyPos = self:GetStraightConnectionPos(endX, endY)
	local result = false
	local tempPos
	local path1 = {}
	local path2 = {}

	for i, v in pairs(emptyPos) do
		result, path1 = self:OneTurnConnection(startX, startY, v.x, v.y)

		if result then
			tempPos = v

			break
		end
	end

	if tempPos then
		result, path2 = self:StraightConnection(endX, endY, tempPos.x, tempPos.y)
	end

	local tab = {}

	if result then
		for i = 1, #path1 do
			tab[#tab + 1] = path1[i]
		end

		tab[#tab + 1] = ROFruitUIPathData.New(tempPos.x, tempPos.y, {})

		for i = 1, #path2 do
			tab[#tab + 1] = path2[i]
		end
	end

	return result, tab
end

function RestaurantGameConnectUI:GetStraightConnectionPos(endX, endY)
	local tempMap = {}
	local m, n = self:GetMapSize()

	for i = endX - 1, 1, -1 do
		if self.mapBoard[i][endY] > 0 then
			break
		end

		tempMap[#tempMap + 1] = {
			x = i,
			y = endY
		}
	end

	for i = endX + 1, m do
		if self.mapBoard[i][endY] > 0 then
			break
		end

		tempMap[#tempMap + 1] = {
			x = i,
			y = endY
		}
	end

	for i = endY - 1, 1, -1 do
		if self.mapBoard[endX][i] > 0 then
			break
		end

		tempMap[#tempMap + 1] = {
			x = endX,
			y = i
		}
	end

	for i = endY + 1, n do
		if self.mapBoard[endX][i] > 0 then
			break
		end

		tempMap[#tempMap + 1] = {
			x = endX,
			y = i
		}
	end

	return tempMap
end

function RestaurantGameConnectUI:OneTurnConnection(startX, startY, endX, endY)
	local path = {}
	local emptyPos = self:GetStraightConnectionPos(endX, endY)
	local result2 = false
	local tempPos
	local path2 = {}

	for i, v in pairs(emptyPos) do
		result2, path2 = self:StraightConnection(startX, startY, v.x, v.y)

		if result2 then
			tempPos = v

			break
		end
	end

	if tempPos then
		local result1, path1 = self:StraightConnection(tempPos.x, tempPos.y, endX, endY)

		if result1 and result2 then
			for i = 1, #path2 do
				path[#path + 1] = path2[i]
			end

			path[#path + 1] = ROFruitUIPathData.New(tempPos.x, tempPos.y, {})

			for i = 1, #path1 do
				path[#path + 1] = path1[i]
			end

			return true, path
		end
	end

	return false, {}
end

function RestaurantGameConnectUI:StraightConnection(startX, startY, endX, endY)
	local path = {}

	if startX == endX then
		local minY, maxY = math.min(startY, endY), math.max(startY, endY)

		for pathY = minY + 1, maxY - 1 do
			if self.mapBoard[startX][pathY] > 0 then
				return false, {}
			end

			local uiPathData = ROFruitUIPathData.New(startX, pathY, {})

			table.insert(path, uiPathData)
		end

		if endY < startY then
			table.reverse(path)
		end

		return true, path
	elseif startY == endY then
		local minX, maxX = math.min(startX, endX), math.max(startX, endX)

		for pathX = minX + 1, maxX - 1 do
			if self.mapBoard[pathX][startY] > 0 then
				return false, {}
			end

			local uiPathData = ROFruitUIPathData.New(pathX, startY, {})

			table.insert(path, uiPathData)
		end

		if endX < startX then
			table.reverse(path)
		end

		return true, path
	end

	return false, {}
end

function RestaurantGameConnectUI:CheckResult()
	if self.isTimeOut then
		UIModule.Open(Constant.UIControllerName.RestaurantGameResultUI, Constant.UILayer.UI, {
			Success = false
		})
	else
		local isPass = true

		for i, v in pairs(ROFruitCleanGameModule.roFruitCleanGameData.fruits) do
			if v.isClean == false then
				isPass = false

				break
			end
		end

		if isPass then
			self.startGame = false

			local passTime = PlayerModule.GetServerTime() - ROFruitCleanGameModule.roFruitCleanGameData.startTime

			UIModule.Open(Constant.UIControllerName.RestaurantGameResultUI, Constant.UILayer.UI, {
				Success = true
			})
			ROFruitCleanGameModule.LinkGame(ROFruitCleanGameModule.roFruitCleanGameData.cid, passTime)
		end
	end
end

return RestaurantGameConnectUI
