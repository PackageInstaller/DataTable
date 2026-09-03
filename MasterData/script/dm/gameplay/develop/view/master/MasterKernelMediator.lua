-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterKernelMediator.lua

local kKernelTabBtnsNames = {
	[1] = "main.layout_5.allKernel.leftTab.tabbtn_all",
	[2] = "main.layout_5.allKernel.leftTab.tabbtn_suit"
}
local kKernelColumnNum = 3
local kQualityBgNames = {
	"zhujue_bg_hexin_bai",
	"zhujue_bg_hexin_lv1",
	"zhujue_bg_hexin_lan1",
	"zhujue_bg_hexin_zi1",
	"zhujue_bg_hexin_cheng1",
	"zhujue_bg_hexin_hong1"
}

function MasterCultivateMediator:initKernelBgTouch()
	local function onTouchBegan(touch, event)
		return true
	end

	local function onTouchEnded(touch, event)
		self:closeAllTips()
	end

	local listener = cc.EventListenerTouchOneByOne:create()

	listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
	self._touchmask:setSwallowTouches(true)

	local eventDispatcher = self._touchmask:getEventDispatcher()

	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self._touchmask)
end

function MasterCultivateMediator:closeAllTips()
	if self._curKernelTipsEquip ~= nil and self._curKernelTipsEquip:isVisible() then
		self._curKernelTipsEquip:setVisible(false)
		self._touchmask:setVisible(false)
	end

	if self._curKernelTipsNoEquip ~= nil and self._curKernelTipsNoEquip:isVisible() then
		self._curKernelTipsNoEquip:setVisible(false)
		self._touchmask:setVisible(false)
	end

	if self._kernelEquipDetailTips ~= nil and self._kernelEquipDetailTips:isVisible() then
		self._kernelEquipDetailTips:setVisible(false)
	end

	if self._detailExpand ~= nil and self._detailExpand:isVisible() then
		self._detailExpand:setVisible(false)
		self._touchmask:setVisible(false)
	end
end

function MasterCultivateMediator:onClickKernelStength(strengthenKernel)
	self._kernelStrengthen:setVisible(true)
	self._kernelStrengthen:setTouchEnabled(true)
	self._kerenlEquip:setVisible(false)

	self._curStrengthenKernel = strengthenKernel

	self._kernelAttrBg:setVisible(false)
	dump(strengthenKernel, "要强化的数据")
	self:refreshStrengthInfo(strengthenKernel)
end

function MasterCultivateMediator:refreshStrengthInfo(data)
	self._kernelStrengthen:getChildByFullName("Text_2"):setString(data.Name)
	self._kernelStrengthen:getChildByFullName("level_old"):setString(data.level)
	self._kernelStrengthen:getChildByFullName("level_new"):setString(data.level + 1)

	local leftexp = 0

	self.rightexp = self._kernelSystem:getNeedExpToNextLevel(data.configId, data.level + 1)

	self._kernelStrengthen:getChildByFullName("Text_11"):setString(leftexp .. "/" .. self.rightexp)
	self._kernelStrengthen:getChildByFullName("slider.Image_8"):setScaleX(leftexp / self.rightexp)

	local left_main_info = self._kernelSystem:getMainEffectDesc(self._curStrengthenKernel)
	local main_info = self._kernelStrengthen:getChildByFullName("strengthInfo.info_old_1")

	main_info:setVisible(true)
	main_info:setString(left_main_info)

	local left_sub_info = self._kernelSystem:getSubEffectDesc(self._curStrengthenKernel)
	local count = 2

	for k, v in pairs(left_sub_info) do
		self._kernelStrengthen:getChildByFullName("strengthInfo.subinfo.arrow_" .. count):setVisible(true)

		local subinfo = self._kernelStrengthen:getChildByFullName("strengthInfo.subinfo.info_old_" .. count)

		subinfo:setVisible(true)
		subinfo:setString(v)

		count = count + 1
	end
end

function MasterCultivateMediator:onClickKernelStengthBtn()
	if #self._kernelSystem:getEatList() <= 0 then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("KERNEL_STRENGTH_LIST")
		}))

		return
	end

	self._kernelSystem:requestStrengthenKernel(self._curStrengthenId, self._kernelSystem:getEatList(), function(data)
		dump(data, "使用核心返回")
	end)
end

function MasterCultivateMediator:initEquipKernelDetailTips()
	self._kernelEquipDetailTips = self._kernelTipsModel:clone()

	self._layoutKernel:addChild(self._kernelEquipDetailTips)
	self._kernelEquipDetailTips:setVisible(false)
	self:refreshEquipKernelAttrInfo()
end

function MasterCultivateMediator:initKernelDetailTips()
	self._kernelDetailTips = self._kernelTipsModel:clone()

	self._layoutKernel:addChild(self._kernelDetailTips)
	self._kernelDetailTips:setVisible(false)
end

function MasterCultivateMediator:initKernelTabBtn()
	self._kernelTabBtns = {}
	self._invalidKernelTabBtns = {}

	for i, name in ipairs(kKernelTabBtnsNames) do
		local btn = self:getView():getChildByFullName(name)

		if btn then
			btn:setTag(i)
			GameStyle:setGreenCommonEffect(btn:getChildByFullName("light_1.text"))

			self._kernelTabBtns[#self._kernelTabBtns + 1] = btn
		end
	end

	self._tabKernelController = TabController:new(self._kernelTabBtns, function(name, tag)
		self:onClickKernelTab(name, tag)
	end)

	self._tabKernelController:setInvalidButtons(self._invalidKernelTabBtns)
	self._tabKernelController:selectTabByTag(self._kernelTabType)
end

function MasterCultivateMediator:initKernelSortTabBtn()
	self._kernelTabSortBtns = {}
	self._invalidKernelSortTabBtns = {}

	for i, name in ipairs(kKernelSortTabBtnsNames) do
		local btn = self:getView():getChildByFullName(name)

		if btn then
			btn:setTag(i)
			GameStyle:setGreenCommonEffect(btn:getChildByFullName("light_1.text"))

			self._kernelTabSortBtns[#self._kernelTabSortBtns + 1] = btn
		end
	end

	self._tabKernelSortController = TabController:new(self._kernelTabSortBtns, function(name, tag)
		self:onClickKernelSrotTab(name, tag)
	end)

	self._tabKernelSortController:setInvalidButtons(self._invalidKernelSortTabBtns)
	self._tabKernelSortController:selectTabByTag(self._kernelTabType)
end

function MasterCultivateMediator:refreshMasterKernel(masterdata)
	self:closeAllTips()

	local kernels = masterdata._kernels

	if #kernels <= 0 then
		self:refreshEquipKernelListView()
	end
end

function MasterCultivateMediator:onKernelClick(sender, eventType, cell, index)
	if eventType == ccui.TouchEventType.began then
		print("点击了一个核心", index)
	end
end

function MasterCultivateMediator:createKernelSuiteTableView()
	self._kernelAllSuiteNum = #self._kernelSystem:getSuiteList()

	print("套装数量::", self._kernelAllSuiteNum)

	local kfirstCellPos = cc.p(-10, 15)

	function scrollViewDidScroll(view)
		return
	end

	function scrollViewDidZoom(view)
		return
	end

	function tableCellTouch(table, cell)
		return
	end

	function cellSizeForTable(table, idx)
		return self._kernelSuitModel:getContentSize().width, self._cellModle:getContentSize().height
	end

	function tableCellAtIndexs(table, idx)
		local cell = table:dequeueCell()
		local suitlist = self._kernelSystem:getSuiteList()

		if cell == nil then
			cell = cc.TableViewCell:new()

			cell:setContentSize(357, 124)

			local index = self._kernelSuitCount + 1
			local kernelCell = self:createKernelSuiteCell(suitlist[index])

			kernelCell:setSwallowTouches(false)

			local posX = kfirstCellPos.x + idx * 35

			kernelCell:setPosition(cc.p(posX, kfirstCellPos.y - idx * 30))
			cell:addChild(kernelCell)

			self._kernelSuitCount = self._kernelSuitCount + 1

			cell:setTag(self._kernelSuitCount)
		end

		return cell
	end

	function numberOfCellsInTableView(table)
		return self._kernelAllSuiteNum
	end

	local kernelSuitTableView = cc.TableView:create(cc.size(400, 349))

	kernelSuitTableView:setTag(668)
	kernelSuitTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	kernelSuitTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self._kernelSuitePanel:addChild(kernelSuitTableView)
	kernelSuitTableView:setAnchorPoint(0, 1)
	kernelSuitTableView:setDelegate()
	kernelSuitTableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	kernelSuitTableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	kernelSuitTableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	kernelSuitTableView:registerScriptHandler(tableCellAtIndexs, cc.TABLECELL_SIZE_AT_INDEX)
	kernelSuitTableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	kernelSuitTableView:reloadData()

	self._allKernelSuiteTableView = kernelSuitTableView
end

function MasterCultivateMediator:createKernelTableView(pos)
	local kerneldata, num = self._developSystem:getKerenlSystem():getAllKernel()
	local kernellistdata = self._developSystem:getKerenlSystem():getKernelIndex()

	self._kernelAllNum = num

	local kfirstCellPos = cc.p(120, -30)
	local kIntervalX = 100
	local kernelinlist = pos ~= nil and self._developSystem:getKerenlSystem():getKernelByPos(pos) or self._developSystem:getKerenlSystem():getKernelIndex()

	self._kernelAllNum = #kernelinlist

	if self._kernelAllNum <= 0 then
		return
	end

	print("服务器下发核心总列表数量:", self._kernelAllNum)

	function scrollViewDidScroll(view)
		return
	end

	function scrollViewDidZoom(view)
		return
	end

	function tableCellTouch(table, cell)
		if self._curKernelCell ~= nil then
			local iconHandler = self._curKernelCell.handler

			if iconHandler and iconHandler:getEntryId() ~= -1 then
				self:selectItem(self._curEntryCell)
			end
		end
	end

	function cellSizeForTable(table, idx)
		return self._cellModle:getContentSize().width + 80, self._cellModle:getContentSize().height
	end

	function tableCellAtIndexs(table, idx)
		local bar = table:dequeueCell()

		if bar == nil then
			bar = cc.TableViewCell:new()

			bar:setContentSize(cc.size(self._cellPanel:getContentSize().width, 90))

			for i = 1, kKernelColumnNum do
				local index = self._kernelCount + 1
				local show = true

				if index > self._kernelAllNum then
					index = self._kernelAllNum
					show = false
				end

				local kernelCellModel = self._cellModle:clone()

				kernelCellModel:setTouchEnabled(true)
				kernelCellModel:setSwallowTouches(false)

				local posX = kfirstCellPos.x + kIntervalX * (i - 1)

				kernelCellModel:setPosition(cc.p(posX, kfirstCellPos.y))
				bar:addChild(kernelCellModel, 0, i)
				kernelCellModel:setVisible(show)

				self._kernelCount = self._kernelCount + 1
			end
		end

		for i = 1, kKernelColumnNum do
			local curIndex = idx * kKernelColumnNum + i
			local show = true

			if curIndex > self._kernelAllNum then
				curIndex = self._kernelAllNum
				show = false
			end

			local kernelCell = bar:getChildByTag(i)

			kernelCell:setVisible(show)

			local posX = kfirstCellPos.x + kIntervalX * (i - 1)

			kernelCell:setPosition(cc.p(posX, kfirstCellPos.y))

			if kernelCell:isVisible() then
				self:updateKernelCell(kernelCell, kernelinlist[curIndex], curIndex)
			end
		end

		return bar
	end

	function numberOfCellsInTableView(table)
		return (math.ceil(self._kernelAllNum / kKernelColumnNum))
	end

	local kernelTableView = cc.TableView:create(cc.size(480, 349))

	kernelTableView:setAnchorPoint(0, 0)
	kernelTableView:setPosition(30, 0)
	kernelTableView:setTag(666)
	kernelTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	kernelTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self._cellPanel:removeAllChildren()
	self._cellPanel:addChild(kernelTableView)

	local pos = cc.p(self._layoutKernel:getChildByFullName("allKernel.left_bg_2.kernelCellPanel"):getPosition())

	kernelTableView:setPosition(pos.x - 40, pos.y + 30)
	kernelTableView:setAnchorPoint(0, 1)
	kernelTableView:setDelegate()
	kernelTableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	kernelTableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	kernelTableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	kernelTableView:registerScriptHandler(tableCellAtIndexs, cc.TABLECELL_SIZE_AT_INDEX)
	kernelTableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	kernelTableView:reloadData()
	self._cellPanel:setRotation(-18)

	self._allKernelTableView = kernelTableView
end

function MasterCultivateMediator:updateKernelCell(iconCell, kerneldata, index)
	iconCell:removeAllChildren()

	local cell = IconFactory:createKernelIcon(kerneldata, {
		needSelect = true,
		isWidget = true
	})
	local btn = cell:getChildByTag(668)

	btn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:onClickLeftKernel(kerneldata, cell)
		end
	end)
	iconCell:addChild(cell)
end

function MasterCultivateMediator:createEquipKernelCell(kerneldata)
	local cell = IconFactory:createKernelIcon(kerneldata, {
		isEquip = true,
		isWidget = true
	})
	local btn = cell:getChildByTag(668)

	btn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:onClickEquipKernel(kerneldata)
		end
	end)

	return cell
end

function MasterCultivateMediator:createKernelCell(kerneldata)
	local cell = IconFactory:createKernelIcon(kerneldata, {
		needSelect = true,
		isWidget = true
	})
	local btn = cell:getChildByTag(668)

	btn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:onClickLeftKernel(kerneldata, cell)
		end
	end)

	return cell
end

function MasterCultivateMediator:createKernelSuiteCell(suitedata)
	local cell = self._kernelSuitModel:clone()

	cell:setAnchorPoint(cc.p(0, 0.5))

	local suite_3_Desc = cell:getChildByName("suit_3")
	local suite_5_Desc = cell:getChildByName("suit_5")
	local suiteHaveNum = cell:getChildByName("havenum")
	local suiteNum = self._kernelSystem:getOneSuiteHaveNum(suitedata)

	suiteHaveNum:setString(suiteNum)
	suite_3_Desc:setString(suitedata.ThreePieceDesc)
	suite_5_Desc:setString(suitedata.FivePieceDesc)

	local btn = cell:getChildByName("Button_3")

	btn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self._allKernelSuiteTableView:setVisible(false)
			self:createKernelSuiteDetail(suitedata)
		end
	end)
	cell:setVisible(true)

	return cell
end

function MasterCultivateMediator:createKernelSuiteDetail(suitedata)
	local firstPos = cc.p(-40, 10)
	local num = #suitedata.IncludeCore
	local kmodel = self._kernelSuiteExpandModel:clone()

	kmodel:setAnchorPoint(cc.p(0, 1))

	local count = 0

	for i = 1, 3 do
		for j = 1, 3 do
			if num < count + 1 then
				break
			end

			local kerneldata = self._kernelSystem:getOneKernelByConfigId(suitedata.IncludeCore[i])

			kerneldata.count = count + 1

			local cell = IconFactory:createKernelIcon(kerneldata, {
				isSuiteExpand = true,
				isWidget = true
			})

			cell:setPosition(firstPos.x + (i - 1) * 25 + j * 96, kmodel:getContentSize().height - i * 80)
			kmodel:addChild(cell)

			count = count + 1
		end
	end

	kmodel:setVisible(true)
	kmodel:setTag(878)

	local suitInfoBtn = kmodel:getChildByFullName("bgimg.Button_4")
	local suiteinfotipe = kmodel:getChildByFullName("Image_14")

	suitInfoBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			print("显示套装描述,套装id:::", suitedata.key, " 三件套描述:", suitedata.ThreePieceDesc, " 五件套描述:", suitedata.FivePieceDesc)
			suiteinfotipe:setVisible(true)

			local text3 = suiteinfotipe:getChildByName("3detail")

			text3:ignoreContentAdaptWithSize(false)
			text3:setContentSize(cc.size(200, 20))

			local text5 = suiteinfotipe:getChildByName("5detail")

			text5:ignoreContentAdaptWithSize(false)
			text5:setContentSize(cc.size(200, 20))
			text3:setString(suitedata.ThreePieceDesc)
			text5:setString(suitedata.FivePieceDesc)
		elseif eventType == ccui.TouchEventType.ended then
			suiteinfotipe:setVisible(false)
		end
	end)
	self._kernelSuitePanel:addChild(kmodel)

	return cell
end

function MasterCultivateMediator:onClickLeftKernel(kerneldata, cell)
	if self._kernelStrengthen:isVisible() then
		print(self._curStrengthenId, "!--!", kerneldata.serverkey)

		if self._curStrengthenId == kerneldata.serverkey then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:find("KERNEL_STRENGTH_ERROR_TIPS")
			}))

			return
		end

		if cell:getChildByTag(888):isVisible() then
			cell:getChildByTag(888):setVisible(false)
			self._kernelSystem:delEatKernelList(kerneldata.serverkey)
		else
			cell:getChildByTag(888):setVisible(true)
			self._kernelSystem:addEatKernelList(kerneldata.serverkey)
		end

		local isselect = cell:getChildByTag(888):isVisible()

		dump(self._kernelSystem:getEatList(), "吞噬列表")

		local eatExp = self._kernelSystem:calculateEatListExp()

		self:refershEatExpShow(eatExp)
		print("eatExp--->", eatExp)

		return
	end

	local kernelDetailTip = self._kernelDetailTips

	kernelDetailTip:setVisible(true)
	self._touchmask:setVisible(true)

	local mastermodel = self:getSelectedMasterData()

	dump(kerneldata, "点击的核心数据")

	local isequip, equipKerneldata = mastermodel:isKernelEquipPos(kerneldata.Position)

	print("该位置是否已装备::", isequip)

	local btnEquip = kernelDetailTip:getChildByFullName("Image_1.btn_equip")
	local btnStrength = kernelDetailTip:getChildByFullName("Image_1.btn_stength")
	local btnReplace = kernelDetailTip:getChildByFullName("Image_1.btn_replace")
	local btnUnload = kernelDetailTip:getChildByFullName("Image_1.btn_unload")

	btnUnload:setVisible(false)
	btnEquip:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			print("装备核心:::" .. kerneldata.serverkey)
			kernelDetailTip:setVisible(false)
			self._touchmask:setVisible(false)

			if self._curKernelTipsEquip ~= nil and self._curKernelTipsEquip:isVisible() then
				self._curKernelTipsEquip:setVisible(false)
			end

			self._kernelSystem:requestUseKernel(kerneldata.serverkey, self._masterSystem:getCurTab1MasterID(), function(data)
				dump(data, "使用核心返回")
			end)
		end
	end)
	btnReplace:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			print("替换核心:::" .. kerneldata.serverkey)
			kernelDetailTip:setVisible(false)
			self._touchmask:setVisible(false)

			if self._curKernelTipsEquip:isVisible() then
				self._curKernelTipsEquip:setVisible(false)
			end

			self._kernelSystem:requestUseKernel(kerneldata.serverkey, self._masterSystem:getCurTab1MasterID(), function(data)
				dump(data, "替换核心返回")
			end)
		end
	end)
	btnStrength:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			print("强化核心:::" .. kerneldata.serverkey)

			self._curStrengthenId = kerneldata.serverkey

			self._touchmask:setVisible(false)
			kernelDetailTip:setVisible(false)

			if self._curKernelTipsEquip ~= nil and self._curKernelTipsEquip:isVisible() then
				self._curKernelTipsEquip:setVisible(false)
			end

			self:onClickKernelStength(kerneldata)

			self._isStrength = true
		end
	end)
	kernelDetailTip:getChildByFullName("Image_1.name"):setString(kerneldata.Name)
	self:setTipsInfo(kernelDetailTip, kerneldata)

	if not isequip then
		btnEquip:setVisible(true)
		btnReplace:setVisible(false)
		kernelDetailTip:getChildByFullName("Image_1.Text_9"):setVisible(false)
	else
		btnEquip:setVisible(false)
		btnReplace:setVisible(true)

		local equipKernelDetailTip = self._kernelTipsModel:clone()

		self:setTipsInfo(equipKernelDetailTip, equipKerneldata)

		local btnUnload = equipKernelDetailTip:getChildByFullName("Image_1.btn_unload")

		btnUnload:setVisible(false)
		equipKernelDetailTip:setVisible(true)
		self._touchmask:setVisible(true)
		equipKernelDetailTip:setPosition(kernelDetailTip:getPositionX() + 350, kernelDetailTip:getPositionY())
		self._layoutKernel:addChild(equipKernelDetailTip)
		equipKernelDetailTip:getChildByFullName("Image_1.name"):setString(self._kernelSystem:getNameByConfigId(equipKerneldata.configId))
		equipKernelDetailTip:getChildByFullName("Image_1.Text_9"):setVisible(true)
		equipKernelDetailTip:getChildByFullName("Image_1.btn_stength"):setVisible(false)
		equipKernelDetailTip:getChildByFullName("Image_1.btn_equip"):setVisible(false)
		equipKernelDetailTip:getChildByFullName("Image_1.btn_replace"):setVisible(false)

		self._curKernelTipsEquip = equipKernelDetailTip
	end

	btnStrength:setVisible(true)
	kernelDetailTip:setVisible(true)

	self._curKernelTipsNoEquip = kernelDetailTip
end

function MasterCultivateMediator:setTipsInfo(tipsmodel, data)
	local icon = self:createKernelCell(data)

	icon:setPosition(tipsmodel:getContentSize().width * 0.15, tipsmodel:getContentSize().height * 0.85)
	tipsmodel:removeChildByTag(886)
	icon:setTag(886)
	tipsmodel:addChild(icon)

	if data.Position == nil then
		local pos = ConfigReader:getDataByNameIdAndKey("MasterCoreBase", data.configId, "Position")

		tipsmodel:getChildByFullName("Image_1.xq_pos"):setString(pos .. "号")
	else
		tipsmodel:getChildByFullName("Image_1.xq_pos"):setString(data.Position .. "号")
	end

	tipsmodel:getChildByFullName("Image_1.Text_9"):setVisible(false)

	local main_desc = self._kernelSystem:getMainEffectDesc(data)

	print("main_desc--->", main_desc)
	tipsmodel:getChildByFullName("Image_1.info_1"):setString(main_desc)

	local sub_desc = self._kernelSystem:getSubEffectDesc(data)
	local subsount = 2

	for k, v in pairs(sub_desc) do
		local subnode = tipsmodel:getChildByFullName("Image_1.info_" .. subsount)

		subnode:setVisible(true)
		subnode:setString(v)

		subsount = subsount + 1
	end

	local descall = self._kernelSystem:getOneSuitDescByKernelId(data.configId)

	tipsmodel:getChildByFullName("Image_1.suite_3"):setString(descall[1])
	tipsmodel:getChildByFullName("Image_1.suite_5"):setString(descall[2])
end

function MasterCultivateMediator:onClickEquipKernel(kerneldata)
	dump(kerneldata, "点击了已装备核心")

	local equiptips = self._kernelEquipDetailTips

	equiptips:setVisible(true)

	local btnEquip = equiptips:getChildByFullName("Image_1.btn_equip")
	local btnStrength = equiptips:getChildByFullName("Image_1.btn_stength")
	local btnUnload = equiptips:getChildByFullName("Image_1.btn_unload")
	local btnReplace = equiptips:getChildByFullName("Image_1.btn_replace")

	equiptips:getChildByFullName("Image_1.name"):setString(self._kernelSystem:getNameByConfigId(kerneldata.configId))
	self:setTipsInfo(equiptips, kerneldata)
	btnEquip:setVisible(false)
	btnReplace:setVisible(false)
	btnStrength:setVisible(false)
	btnUnload:setVisible(true)
	equiptips:setVisible(true)
	btnUnload:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			print("卸下核心:::" .. kerneldata.id)
			self:getSelectedMasterData():setUnloadkernelid(kerneldata.id)

			self._unloadKernelId = kerneldata.id

			equiptips:setVisible(false)
			self._kernelSystem:requestUnloadKernel(self._kernelSystem:getPosByConfigId(kerneldata.configId), self._masterSystem:getCurTab1MasterID(), function(data)
				dump(data, "卸下核心返回")
			end)
		end
	end)
end

function MasterCultivateMediator:createEquipKernel()
	local mastermodel = self:getSelectedMasterData()
	local equipkernellist = mastermodel:getEquipKernelsList()

	for i = 1, 8 do
		local pos = i
		local posParent = self._layoutKernel:getChildByFullName("oneSuitKenerl.iconmodel_" .. pos)

		posParent:removeAllChildren()
	end

	for k, v in pairs(equipkernellist) do
		local cell = self:createEquipKernelCell(v)
		local pos = ConfigReader:getDataByNameIdAndKey("MasterCoreBase", v.configId, "Position")
		local quality = ConfigReader:getDataByNameIdAndKey("MasterCoreBase", v.configId, "Quality")
		local posParent = self._layoutKernel:getChildByFullName("oneSuitKenerl.iconmodel_" .. pos)

		posParent:removeAllChildren()

		local qualityImg = self._layoutKernel:getChildByFullName("oneSuitKenerl.pos_" .. pos)

		qualityImg:loadTexture("asset/ui/mastercultivate/" .. kQualityBgNames[quality] .. ".png")
		posParent:addChild(cell)
	end
end

function MasterCultivateMediator:refreshKernelListView(pos)
	self._kernelCount = 0

	if self._allKernelTableView then
		if #self._allKernelTableView:getChildren() > 0 then
			self._allKernelTableView:removeAllChildren()
		end

		if pos ~= nil then
			if #self._kernelSystem:getKernelByPos(pos) > 0 then
				self:createKernelTableView(pos)
			end
		else
			self:createKernelTableView()
		end
	end
end

function MasterCultivateMediator:refreshEquipKernelListView()
	self:createEquipKernel()
end

function MasterCultivateMediator:refreshEquipKernelAttrInfo()
	local _equipdata = self:getSelectedMasterData():getEquipKernelsList()
	local equipAttrSum = self._kernelSystem:calculateEquipListAttribute(_equipdata)
	local countattr = 1

	for k, v in pairs(equipAttrSum) do
		self._kernelAttrBg:getChildByFullName("attr_" .. countattr .. ".text"):setString(v)

		countattr = countattr + 1
	end
end

function MasterCultivateMediator:updateKernelList()
	self:refreshKernelListView()
	self:refreshEquipKernelListView()
	self:refreshEquipKernelAttrInfo()
end

function MasterCultivateMediator:updateStrengthenKernelList()
	self._kernelSystem:resetEatList()
	self:refreshKernelListView()
	self:refreshEquipKernelListView()
	self:refreshStrengthInfo(self._kernelSystem:findKernelOneKernelInt(self._curStrengthenId))
	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = Strings:find("KERNEL_STRENGTH_SUC")
	}))
end

function MasterCultivateMediator:updateUnloadKerne()
	self:refreshKernelListView()
	self:refreshEquipKernelListView()
end

function MasterCultivateMediator:onClickKernelPos()
	self._posBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._posTips:setVisible(not self._posTips:isVisible())
			self._levelTips:setVisible(false)
		end
	end)

	local posbtnlist = {}

	for i = 1, 8 do
		posbtnlist[i] = self._layoutKernel:getChildByFullName("poslist.posBg.po_" .. i)

		posbtnlist[i]:setTag(i)
		posbtnlist[i]:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self._selectPos = sender:getTag()

				self._layoutKernel:getChildByFullName("allKernel.rightTab.btn_pos.text_level"):setString(kKernelPos[self._selectPos])
				self._posTips:setVisible(false)
				self:refershKernelShowByPos()
			end
		end)
	end
end

function MasterCultivateMediator:refershKernelShowByPos()
	self._kernelCount = 0

	local posdata = self._kernelSystem:getKernelByPos(self._selectPos)

	self:refreshKernelListView(self._selectPos)
end

function MasterCultivateMediator:onClickKernelLevel()
	self._levelBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self._levelTips:setVisible(not self._levelTips:isVisible())
			self._posTips:setVisible(false)
		end
	end)

	for i = 1, 12 do
		local btn = self._layoutKernel:getChildByFullName("level.levelBg.btn_type_" .. i)

		btn:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				local sortType = string.split(sender:getName(), "_")[3]

				print(sender:getChildByName("leveltype"):getString(), " 排序类型 ", sortType)
				self._kernelSystem:sortListByType(self._kernelSystem:getAllKernel(), 1)
			end
		end)
	end
end

function MasterCultivateMediator:initKernelWiget()
	self._layoutKernel = self:getView():getChildByFullName("main.layout_5")
	self._cellPanel = self:getView():getChildByFullName("main.layout_5.allKernel.left_bg_2.kernelCellPanel")
	self._touchmask = self._layoutKernel:getChildByFullName("ktouchmask")

	self._touchmask:setVisible(false)

	self._posBtn = self._layoutKernel:getChildByFullName("allKernel.rightTab.btn_pos")
	self._posTips = self._layoutKernel:getChildByName("poslist")

	self._posTips:setVisible(false)
	self._posTips:setSwallowTouches(true)

	self._levelBtn = self._layoutKernel:getChildByFullName("allKernel.rightTab.btn_level")
	self._levelTips = self._layoutKernel:getChildByName("level")

	self._levelTips:setVisible(false)
	self._levelTips:setSwallowTouches(true)

	self._kerenlEquip = self._layoutKernel:getChildByFullName("oneSuitKenerl")
	self._kernelAllNum = 0
	self._kernelAllSuiteNum = 0
	self._kernelTipsModel = self._layoutKernel:getChildByFullName("detailModel")

	self._kernelTipsModel:setVisible(false)

	self._curKernelTipsNoEquip = nil
	self._oneKernelModel = self._layoutKernel:getChildByFullName("allKernel.left_bg_2.oneKernel")
	self._kernelCount = 0
	self._cellModle = self._layoutKernel:getChildByFullName("allKernel.left_bg_2.kernelmodle")
	self._kernelStrengthen = self._layoutKernel:getChildByFullName("strengthen")

	self._kernelStrengthen:setVisible(false)
	self._kernelStrengthen:setTouchEnabled(false)

	self._kerenlStrengthenBtn = self._kernelStrengthen:getChildByFullName("Button_1")
	self._kernelAllPanel = self._layoutKernel:getChildByFullName("allKernel.left_bg_2")
	self._kernelSuitePanel = self._layoutKernel:getChildByFullName("allKernel.left_bg_suitePanel")
	self._kernelSuitModel = self._kernelSuitePanel:getChildByFullName("suitemodel")

	self._kernelSuitModel:setVisible(false)

	self._kernelSuitCount = 0
	self._kernelSuiteExpandModel = self._layoutKernel:getChildByFullName("allKernel.left_bg_suitePanel.suitExpand")

	self._kernelSuiteExpandModel:setVisible(false)

	self._suitBtn = self._layoutKernel:getChildByFullName("allKernel.rightTab.btn_suite")
	self._unloadKernelId = nil
	self._kernelAttrBg = self._layoutKernel:getChildByFullName("attributeBg")
	self._isStrength = false

	self:createKernelTableView()
	self:createKernelSuiteTableView()
	self:createEquipKernel()
	self:initKernelEquip()
	self:initKernelStrengthen()
	self:initEquipKernelDetailTips()
	self:initKernelDetailTips()
	self:onClickKernelPos()
	self:onClickKernelLevel()
	self:initKernelBgTouch()
	self:initKernelDetail()
end

function MasterCultivateMediator:initKernelDetail()
	self._detailExpand = self._layoutKernel:getChildByFullName("attributeBg.detailExpand")

	self._detailExpand:setVisible(false)

	self._detailBtn = self._layoutKernel:getChildByFullName("attributeBg.btn_detail")
	self._detailList = self._layoutKernel:getChildByFullName("attributeBg.detailExpand.attrlist")

	self._detailBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self._touchmask:setVisible(true)
			print("展开详细信息")

			local _equipdata = self:getSelectedMasterData():getEquipKernelsList()
			local equipAttrSum = self._kernelSystem:calculateEquipListAttribute(_equipdata)

			self._detailExpand:setVisible(not self._detailExpand:isVisible())

			if self._detailExpand:isVisible() then
				for k, v in pairs(self._detailList:getChildren()) do
					v:setVisible(false)
				end

				local count = 1

				for k, v in pairs(equipAttrSum) do
					local attrnode = self._detailList:getChildByFullName("att_" .. count)

					attrnode:setString(k .. v)
					attrnode:setVisible(true)

					count = count + 1
				end

				local suitedesc = self._kernelSystem:getEquipSuiteDesc(_equipdata)

				self._detailExpand:getChildByFullName("suite_3_info"):setVisible(false)
				self._detailExpand:getChildByFullName("suite_5_info"):setVisible(false)

				for k, v in pairs(suitedesc) do
					if v ~= nil then
						self._detailExpand:getChildByFullName(k):setVisible(true)
						self._detailExpand:getChildByFullName(k):setString(v)
					end
				end
			end
		end
	end)
end

function MasterCultivateMediator:setKernelType(tabtype)
	if tabtype == 1 then
		self._kernelAllPanel:setVisible(true)
		self._kernelSuitePanel:setVisible(false)
		self._suitBtn:setVisible(true):setVisible(false)
		self._posBtn:setVisible(true)

		if self._kernelSuitePanel:getChildByTag(878) ~= nil then
			self._kernelSuitePanel:removeChildByTag(878)
		end
	elseif tabtype == 2 then
		self._kernelAllPanel:setVisible(false)
		self._kernelSuitePanel:setVisible(true)
		self._allKernelSuiteTableView:setVisible(true)
		self._posBtn:setVisible(false)
		self._suitBtn:setVisible(true)
	end
end

function MasterCultivateMediator:initKernelEquip()
	for i = 1, 8 do
		local equipkernelbtn = self._layoutKernel:getChildByFullName("oneSuitKenerl.btn_pos_" .. i)

		equipkernelbtn:setTag(i)
		equipkernelbtn:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				print("点击了装备位置" .. i)
			end
		end)
	end
end

function MasterCultivateMediator:initKernelStrengthen()
	self._kerenlStrengthenBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self:onClickKernelStengthBtn()
		end
	end)
end
