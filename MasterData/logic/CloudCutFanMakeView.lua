-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cloudcutfan/view/CloudCutFanMakeView.lua

module("logic.extensions.cloudcutfan.view.CloudCutFanMakeView", package.seeall)

local CloudCutFanMakeView = class("CloudCutFanMakeView", ViewComponent)
local UseMatTypeCount = 3

function CloudCutFanMakeView:ctor()
	CloudCutFanMakeView.super.ctor(self)
end

function CloudCutFanMakeView:unbindEvents()
	CloudCutFanMakeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStartMake)
	GameUtil.rmClickHandler(self._btnBook)
end

function CloudCutFanMakeView:bindEvents()
	CloudCutFanMakeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStartMake, self._onClickBtnStartMake, self)
	GameUtil.addClickHandler(self._btnBook, self._onClickBtnBook, self)
end

function CloudCutFanMakeView:buildUI()
	CloudCutFanMakeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnStartMake = self:getGo("btnStartMake")
	self._btnBook = self:getGo("btnBook")
	self._curSelectTypeIdMap = {}
	self._curSelectTypeCellList = {}
	self._tableviewMatListMap = {}

	for i = 1, UseMatTypeCount do
		self._curSelectTypeIdMap[i] = 0

		local cell = {}

		cell.go = self:getGo("selectType" .. i)
		cell.markEmpty = goutil.findChild(cell.go, "empty")
		cell.icon = goutil.findChild(cell.go, "icon")
		self._curSelectTypeCellList[i] = cell

		local goTab = self:getGo(string.format("selectList%s/tableview", i))
		local goCell = goutil.findChild(goTab, "tablecell")

		self._tableviewMatListMap[i] = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	end

	self._goldBarCon = self:getGo("goldBarCon")
	self._showFan = self:getGo("showFan")
	self._topFan = self:getGo("showFan/top")
	self._faceFan = self:getGo("showFan/cover/face")
	self._tailFan = self:getGo("showFan/tail")
	self._coverFan = self:getGo("showFan/cover")
	self._markUnlock = self:getGo("markUnlock")
	self._markLock = self:getGo("markLock")
end

function CloudCutFanMakeView:onExit()
	CloudCutFanMakeView.super.onExit(self)

	for i, cell in ipairs(self._curSelectTypeCellList) do
		uGuiUtil.clearImage(cell.icon)
	end

	for _, tableview in ipairs(self._tableviewMatListMap) do
		tableview:dispose()
	end

	uGuiUtil.clearImage(self._topFan)
	uGuiUtil.clearImage(self._tailFan)
	uGuiUtil.clearImage(self._coverFan)
	uGuiUtil.clearImage(self._faceFan)
end

function CloudCutFanMakeView:onEnter()
	CloudCutFanMakeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_CloudCutFanMakeFanRes, self._handleMakeFanRes, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = CloudCutFanController.instance:getDefaultActivityId() or 0
	end

	self:_updateUIByCfg()

	for i = 1, UseMatTypeCount do
		self:_refreshType(i, 0, true)
	end
end

function CloudCutFanMakeView:_updateUIByCfg()
	self._actCfg = CloudCutFanConfig.instance:getActCfgByActId(self._activityId) or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._useMatCfgListMap = {}

	for i = 1, UseMatTypeCount do
		self._useMatCfgListMap[i] = CloudCutFanConfig.instance:getMaterialCfgListByType(self._activityId, i) or {}
	end

	if not self._actCfg.costItem then
		local costMatItemStr = ""
		local btn_list = {
			{
				showAdd = false,
				id = costMatItemStr
			}
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
	end
end

function CloudCutFanMakeView:_handleMakeFanRes()
	TipsFacade.instance:openTipWindowNoX(lang("提示"), lang("完成制作"), function()
		self:close()
	end)
end

function CloudCutFanMakeView:_refreshType(typeId, curMatId, isForce)
	if isForce then
		self._curSelectTypeIdMap[typeId] = -1
	end

	local lastSelectMatId = checknumber(self._curSelectTypeIdMap[typeId])

	if lastSelectMatId == curMatId then
		return
	end

	self._curSelectTypeIdMap[typeId] = curMatId

	local curSelectTypeCell = self._curSelectTypeCellList[typeId]
	local matCfg = CloudCutFanConfig.instance:getMaterialCfgById(self._activityId, curMatId)

	if matCfg then
		goutil.setActive(curSelectTypeCell.markEmpty, false)
		goutil.setActive(curSelectTypeCell.icon, true)
		uGuiUtil.clearImage(curSelectTypeCell.icon)

		local picPath = CloudCutFanController.instance:getUseMatPicUrl(matCfg.picPath)

		if not GameUtil.isEmptyString(picPath) then
			uGuiUtil.setSpriteToImage(curSelectTypeCell.icon, uGuiUtil.SpriteType.BigBg, picPath, function()
				local img = curSelectTypeCell.icon:GetComponent(goutil.Type_UIImage)

				img:SetNativeSize()

				img.raycastTarget = false
			end)
		end
	else
		goutil.setActive(curSelectTypeCell.markEmpty, true)
		goutil.setActive(curSelectTypeCell.icon, false)
	end

	local tableview = self._tableviewMatListMap[typeId]

	if tableview then
		if not self._useMatCfgListMap[typeId] then
			tableview:reloadData(self._useMatCfgListMap[typeId])
		end
	end

	self:_freshShowFan()
end

function CloudCutFanMakeView:_freshShowFan()
	local isNeedShow = true

	for i = 1, UseMatTypeCount do
		if self._curSelectTypeIdMap[i] <= 0 then
			isNeedShow = false

			break
		end
	end

	goutil.setActive(self._markUnlock, false)
	goutil.setActive(self._markLock, false)
	goutil.setActive(self._btnStartMake, isNeedShow)
	goutil.setActive(self._showFan, isNeedShow)

	if isNeedShow then
		uGuiUtil.clearImage(self._topFan)
		uGuiUtil.clearImage(self._tailFan)
		uGuiUtil.clearImage(self._coverFan)
		uGuiUtil.clearImage(self._faceFan)

		local topMatId = checknumber(self._curSelectTypeIdMap[2])
		local topMatCfg = CloudCutFanConfig.instance:getMaterialCfgById(self._activityId, topMatId)

		if topMatCfg then
			local topPath = topMatCfg.picPath
			local coverPath = string.format("%s_02", topPath)
			local trueTopPath = CloudCutFanController.instance:getUseMatPicUrl(topPath)
			local trueCoverPath = CloudCutFanController.instance:getUseMatPicUrl(coverPath)

			if not GameUtil.isEmptyString(trueTopPath) then
				uGuiUtil.setSpriteToImage(self._topFan, uGuiUtil.SpriteType.BigBg, trueTopPath, function()
					local img = self._topFan:GetComponent(goutil.Type_UIImage)

					img:SetNativeSize()

					img.raycastTarget = false
				end)
			end

			if not GameUtil.isEmptyString(trueCoverPath) then
				uGuiUtil.setSpriteToImage(self._coverFan, uGuiUtil.SpriteType.BigBg, trueCoverPath, function()
					local img = self._coverFan:GetComponent(goutil.Type_UIImage)

					img:SetNativeSize()

					img.raycastTarget = false
				end)
			end
		end

		local faceMatId = checknumber(self._curSelectTypeIdMap[1])
		local faceCfg = CloudCutFanConfig.instance:getMaterialCfgById(self._activityId, faceMatId)

		if faceCfg then
			local trueFacePath = CloudCutFanController.instance:getUseMatPicUrl(faceCfg.picPath)

			if not GameUtil.isEmptyString(trueFacePath) then
				uGuiUtil.setSpriteToImage(self._faceFan, uGuiUtil.SpriteType.BigBg, trueFacePath, function()
					local img = self._faceFan:GetComponent(goutil.Type_UIImage)

					img:SetNativeSize()

					img.raycastTarget = false
				end)
			end
		end

		local tailMatId = checknumber(self._curSelectTypeIdMap[3])
		local tailCfg = CloudCutFanConfig.instance:getMaterialCfgById(self._activityId, tailMatId)

		if tailCfg then
			local trueTailPath = CloudCutFanController.instance:getUseMatPicUrl(tailCfg.picPath)

			if not GameUtil.isEmptyString(trueTailPath) then
				uGuiUtil.setSpriteToImage(self._tailFan, uGuiUtil.SpriteType.BigBg, trueTailPath, function()
					local img = self._tailFan:GetComponent(goutil.Type_UIImage)

					img:SetNativeSize()

					img.raycastTarget = false
				end)
			end
		end

		local showFanCfg = CloudCutFanConfig.instance:getFanMakeCfgByRecipe(self._activityId, faceMatId, topMatId, tailMatId)

		if showFanCfg then
			if not showFanCfg.fanId then
				local fanId = 0
				local isUnlocked = CloudCutFanModel.instance:isFanUnlocked(self._activityId, fanId)

				goutil.setActive(self._markUnlock, isUnlocked)
				goutil.setActive(self._markLock, not isUnlocked)
			end
		end
	end
end

function CloudCutFanMakeView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function CloudCutFanMakeView:_onClickBtnBook()
	UIStateManager.instance:push(ViewName.CloudCutFanBookView, self._activityId)
end

function CloudCutFanMakeView:_onClickBtnStartMake()
	local faceMatId = checknumber(self._curSelectTypeIdMap[1])
	local topMatId = checknumber(self._curSelectTypeIdMap[2])
	local tailMatId = checknumber(self._curSelectTypeIdMap[3])
	local showFanCfg = CloudCutFanConfig.instance:getFanMakeCfgByRecipe(self._activityId, faceMatId, topMatId, tailMatId)
	local addTips = "\n当前扇子<color=#eb4642>未解锁</color>图鉴，消耗<color=#eb4642>1次</color>制作次数"
	local mat1Cfg = CloudCutFanConfig.instance:getMaterialCfgById(self._activityId, faceMatId) or {}
	local mat1Cfg

	if showFanCfg then
		mat1Cfg = showFanCfg.fanId

		if not showFanCfg.fanId then
			do
				local fanId = 0
				local isUnlocked = CloudCutFanModel.instance:isFanUnlocked(self._activityId, fanId)

				if isUnlocked then
					addTips = "\n当前扇子<color=#eb4642>已解锁</color>图鉴，不消耗次数"
				end
			end

			if faceMatId <= 0 or topMatId <= 0 or tailMatId <= 0 then
				TipsFacade.instance:openCommonTips(lang("请选择完整的材料类型"))

				return
			end
		end
	end

	local mat2Cfg = CloudCutFanConfig.instance:getMaterialCfgById(self._activityId, topMatId) or {}
	local mat3Cfg = CloudCutFanConfig.instance:getMaterialCfgById(self._activityId, tailMatId) or {}

	if not mat1Cfg.craftCost then
		local costMat1 = ""

		if not mat2Cfg.craftCost then
			local costMat2 = ""

			if not mat3Cfg.craftCost then
				local costMat3 = ""
				local matType1, matId1, matNum1 = MaterialMgr.getMatParams(costMat1)
				local matType2, matId2, matNum2 = MaterialMgr.getMatParams(costMat2)
				local matType3, matId3, matNum3 = MaterialMgr.getMatParams(costMat3)
				local totalCost = matNum1 + matNum2 + matNum3
				local tips = langPara("确定消耗%s%s开始制作扇子？%s", totalCost, MaterialMgr.getMaterialsName(matType1, matId1), addTips)

				TipsFacade.instance:openPopupCostMatViewNew(matType1, matId1, totalCost, tips, function()
					CloudCutFanController.instance:makeFan(self._activityId, faceMatId, topMatId, tailMatId)
				end)
			end
		end
	end
end

function CloudCutFanMakeView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local icon = goutil.findChild(go, "item/icon")
	local txtCost = goutil.findChildTextComponent(go, "cost/txt")
	local iconCost = goutil.findChild(go, "cost/txt/icon")
	local markSelect = goutil.findChild(go, "markSelect")

	if not data.typeId then
		local typeId = 1
		local curSelectId = checknumber(self._curSelectTypeIdMap[typeId])

		if not data.materialId then
			local materialId = 1
			local isSelect = materialId == curSelectId
			local truePicPath = CloudCutFanController.instance:getUseMatPicUrl(data.picPath)

			if not data.craftCost then
				local craftCost = ""
				local costType, costId, costNum = MaterialMgr.getMatParams(craftCost)

				txtCost.text = costNum

				MaterialMgr.setIcon(iconCost, costType, costId)
				goutil.setActive(markSelect, isSelect)
				uGuiUtil.clearImage(icon)

				if not GameUtil.isEmptyString(truePicPath) then
					uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, truePicPath, function()
						local img = icon:GetComponent(goutil.Type_UIImage)

						img:SetNativeSize()

						img.raycastTarget = false
					end)
				end

				GameUtil.addClickHandler(btn, GameUtil.handler(self._refreshType, self, typeId, materialId, false))
			end
		end
	end
end

function CloudCutFanMakeView:_clearCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)

	local icon = goutil.findChild(go, "item/icon")

	uGuiUtil.clearImage(icon)

	local iconCost = goutil.findChild(go, "cost/txt/icon")

	MaterialMgr.resetAll(iconCost)
end

return CloudCutFanMakeView
