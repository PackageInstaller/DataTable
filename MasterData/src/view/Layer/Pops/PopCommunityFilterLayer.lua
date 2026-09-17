PopCommunityFilterLayer = class("PopCommunityFilterLayer", function()
	return PopBaseLayer:create()
end)

require("view.Layer.PopLayer")

local item_data = require("data.item_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local family_tag_data = require("data.family_tag_data")
local var_0_5 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local var_0_7 = 386
local var_0_8 = 40
local var_0_9 = {
	cc.p(6, 0),
	cc.p(110, 0),
	cc.p(220, 0),
	(cc.p(330, 0))
}
local var_0_10 = {
	off = cc.c3b(255, 255, 255),
	on = cc.c3b(0, 0, 0)
}
local var_0_11 = {
	sort = {
		title = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips1,
		title1 = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips2,
		title2 = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips3,
		down = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips4,
		up = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips5,
		deflaut = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips6,
		level = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips7,
		member = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips8,
		active = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips9,
		online = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips10,
		week = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips11,
		total = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips12
	},
	filter = {
		title = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips13,
		title1 = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips14,
		title2 = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips15,
		need = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips16,
		noneed = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips17
	}
}
local var_0_12 = {
	on = "public/filter/filter_selected_bg.png",
	off = "public/filter/filter_select_bg.png"
}

function PopCommunityFilterLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCommunityFilterLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopCommunityFilterLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunityFilterLayer.json" or "PopCommunityFilterLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.titlename = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_64")
	self.panel1 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel1")
	self.panel2 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel2")
	self.surebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_30")
	self.sortnode = ccui.Helper:seekWidgetByName(self.panel1, "sort_img")
	self.filternode = ccui.Helper:seekWidgetByName(self.panel1, "filter_img")
	self.tablelayer = ccui.Helper:seekWidgetByName(self.filternode, "tablelayer")
	self.sortdown = ccui.Helper:seekWidgetByName(self.sortnode, "sortdown")
	self.sortup = ccui.Helper:seekWidgetByName(self.sortnode, "sortup")
	self.sortdefault = ccui.Helper:seekWidgetByName(self.sortnode, "sortdefault")
	self.sortlevel = ccui.Helper:seekWidgetByName(self.sortnode, "sortlevel")
	self.sortmember = ccui.Helper:seekWidgetByName(self.sortnode, "sortmember")
	self.sortactivity = ccui.Helper:seekWidgetByName(self.sortnode, "sortactivity")
	self.editdefault = ccui.Helper:seekWidgetByName(self.filternode, "editdefault")
	self.editneed = ccui.Helper:seekWidgetByName(self.filternode, "editneed")
	self.ListViewlable = ccui.Helper:seekWidgetByName(self.filternode, "ListView_28")
	self.membersort = ccui.Helper:seekWidgetByName(self.panel2, "sort_img")
	self.membersortdown = ccui.Helper:seekWidgetByName(self.panel2, "sortdown")
	self.membersortup = ccui.Helper:seekWidgetByName(self.panel2, "sortup")
	self.membersortonline = ccui.Helper:seekWidgetByName(self.panel2, "sortonline")
	self.membersortweek = ccui.Helper:seekWidgetByName(self.panel2, "sortweek")
	self.membersorttotal = ccui.Helper:seekWidgetByName(self.panel2, "sorttotal")

	self.surebtn:getChildByName("Label_4"):setString(COMMUNITY_POPCOMMUNITYNOTICESLAYER.tips2)

	self.veritynodes = {
		self.editdefault,
		self.editneed
	}
	self.sortnode1 = {
		self.sortdown,
		self.sortup
	}
	self.sortnode2 = {
		self.sortdefault,
		self.sortlevel,
		self.sortmember,
		self.sortactivity
	}
	self.sortnode3 = {
		self.membersortdown,
		self.membersortup
	}
	self.sortnode4 = {
		self.membersortonline,
		self.membersortweek,
		self.membersorttotal
	}

	self.titlename:setString("")

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")

	self.rootpanel:setCascadeOpacityEnabled(false)
	self.rootpanel:setPositionY(590 + GameDisplay.fix_y)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	if arg_3_1 then
		self.callback = arg_3_1.callback or nil
	end

	if arg_3_1 then
		self.filtertype = arg_3_1.filtertype or 1
	end

	if self.filtertype == 1 then
		self.panel1:setVisible(true)
		self.panel2:setVisible(false)
		self.titlename:setString(COMMUNITY_POPCOMMUNITYFILTERLAYER.tips18)
	else
		self.panel1:setVisible(false)
		self.panel2:setVisible(true)
		self.titlename:setString(COMMUNITY_POPCOMMUNITYFILTERLAYER.tips19)
	end

	self:initUI()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

function PopCommunityFilterLayer:initUI()
	local var_7_0 = community_system_manager:getComminityFilterParm()

	self.sortdownup = var_7_0.sortdownup
	self.sorttype = var_7_0.sorttype
	self.labels = var_7_0.labelindex
	self.verityid = var_7_0.verityid
	self.membersortdownup = var_7_0.membersortdownup
	self.membersorttype = var_7_0.membersorttype

	self:initLayerText()
	self:initSortPanel()
	self:initFilterPanel()
	self:initMemberPanel()
	self.surebtn:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.filtertype == 1 then
			local var_8_0 = {}

			for iter_8_0, iter_8_1 in pairs(self.labs) do
				if iter_8_1:getChildByName("Button_50").selet == 1 then
					table.insert(var_8_0, iter_8_1.id)
				end
			end

			community_system_manager:updateComminityFilterParm({
				sortdownup = self.sortdownup,
				sorttype = self.sorttype,
				labelindex = var_8_0,
				verityid = self.verityid
			})
		else
			community_system_manager:updateComminityMemberSortParm({
				membersortdownup = self.membersortdownup,
				membersorttype = self.membersorttype
			})
		end

		self:exit()
	end)
end

function PopCommunityFilterLayer:initLayerText()
	ccui.Helper:seekWidgetByName(self.sortnode, "Label_9"):setString(var_0_11.sort.title)
	ccui.Helper:seekWidgetByName(self.sortnode, "title1"):setString(var_0_11.sort.title1)
	ccui.Helper:seekWidgetByName(self.sortnode, "title2"):setString(var_0_11.sort.title2)
	ccui.Helper:seekWidgetByName(self.sortdown, "name"):setString(var_0_11.sort.down)
	ccui.Helper:seekWidgetByName(self.sortup, "name"):setString(var_0_11.sort.up)
	ccui.Helper:seekWidgetByName(self.sortdefault, "name"):setString(var_0_11.sort.deflaut)
	ccui.Helper:seekWidgetByName(self.sortlevel, "name"):setString(var_0_11.sort.level)
	ccui.Helper:seekWidgetByName(self.sortmember, "name"):setString(var_0_11.sort.member)
	ccui.Helper:seekWidgetByName(self.sortactivity, "name"):setString(var_0_11.sort.active)
	ccui.Helper:seekWidgetByName(self.sortactivity, "name"):setString(var_0_11.sort.active)
	ccui.Helper:seekWidgetByName(self.filternode, "Label_9"):setString(var_0_11.filter.title)
	ccui.Helper:seekWidgetByName(self.filternode, "title1"):setString(var_0_11.filter.title1)
	ccui.Helper:seekWidgetByName(self.filternode, "title2"):setString(var_0_11.filter.title2)
	ccui.Helper:seekWidgetByName(self.editdefault, "name"):setString(var_0_11.filter.noneed)
	ccui.Helper:seekWidgetByName(self.editneed, "name"):setString(var_0_11.filter.need)
	ccui.Helper:seekWidgetByName(self.membersort, "Label_9"):setString(var_0_11.sort.title)
	ccui.Helper:seekWidgetByName(self.membersort, "title1"):setString(var_0_11.sort.title1)
	ccui.Helper:seekWidgetByName(self.membersort, "title2"):setString(var_0_11.sort.title2)
	ccui.Helper:seekWidgetByName(self.membersortdown, "name"):setString(var_0_11.sort.down)
	ccui.Helper:seekWidgetByName(self.membersortup, "name"):setString(var_0_11.sort.up)
	ccui.Helper:seekWidgetByName(self.membersortonline, "name"):setString(var_0_11.sort.online)
	ccui.Helper:seekWidgetByName(self.membersortweek, "name"):setString(var_0_11.sort.week)
	ccui.Helper:seekWidgetByName(self.membersorttotal, "name"):setString(var_0_11.sort.total)
end

function PopCommunityFilterLayer:initMemberPanel()
	self:updateMemberPanelBtn()

	for iter_10_0, iter_10_1 in ipairs(self.sortnode3) do
		iter_10_1:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.membersortdownup = iter_10_0

			self:updateMemberPanelBtn()
		end)
	end

	for iter_10_2, iter_10_3 in ipairs(self.sortnode4) do
		iter_10_3:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.membersorttype = iter_10_2

			self:updateMemberPanelBtn()
		end)
	end
end

function PopCommunityFilterLayer:updateMemberPanelBtn()
	if not self.membersortdownup then
		self.sortnode3[1]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
		self.sortnode3[2]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
		self.sortnode3[1]:getChildByName("name"):setColor(var_0_10.off)
		self.sortnode3[2]:getChildByName("name"):setColor(var_0_10.off)
	elseif self.membersortdownup == 1 then
		self.sortnode3[1]:loadTextures(var_0_12.on, nil, var_0_12.on, var_0_5)
		self.sortnode3[2]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
		self.sortnode3[1]:getChildByName("name"):setColor(var_0_10.on)
		self.sortnode3[2]:getChildByName("name"):setColor(var_0_10.off)
	else
		self.sortnode3[1]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
		self.sortnode3[2]:loadTextures(var_0_12.on, nil, var_0_12.on, var_0_5)
		self.sortnode3[1]:getChildByName("name"):setColor(var_0_10.off)
		self.sortnode3[2]:getChildByName("name"):setColor(var_0_10.on)
	end

	if not self.membersorttype then
		for iter_13_0 = 1, 3 do
			self.sortnode4[iter_13_0]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
			self.sortnode4[iter_13_0]:getChildByName("name"):setColor(var_0_10.off)
		end
	else
		for iter_13_1 = 1, 3 do
			if self.membersorttype == iter_13_1 then
				self.sortnode4[iter_13_1]:loadTextures(var_0_12.on, nil, var_0_12.on, var_0_5)
				self.sortnode4[iter_13_1]:getChildByName("name"):setColor(var_0_10.on)
			else
				self.sortnode4[iter_13_1]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
				self.sortnode4[iter_13_1]:getChildByName("name"):setColor(var_0_10.off)
			end
		end
	end
end

function PopCommunityFilterLayer:initSortPanel()
	self:updateSorTypeNode()
	self:updateSortUpDownNode()
	self.sortdown:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.sortdownup = 1

		self:updateSortUpDownNode()
	end)
	self.sortup:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.sortdownup = 2

		self:updateSortUpDownNode()
	end)

	for iter_14_0, iter_14_1 in ipairs(self.sortnode2) do
		iter_14_1:addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.sorttype = iter_14_0

			self:updateSorTypeNode()
		end)
	end
end

function PopCommunityFilterLayer:initFilterPanel()
	self:initLableLayer()
	self:initVerityLayer()
end

function PopCommunityFilterLayer.createTableView(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = cc.TableView:create(arg_19_1)

	;(nil):setName(arg_19_2)
	var_19_0:setDelegate()
	var_19_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_19_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

	return var_19_0
end

function PopCommunityFilterLayer:initVerityLayer()
	self:updateVerityNode()
	self.editdefault:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.verityid == 1 then
			self.verityid = nil
		else
			self.verityid = 1
		end

		self:updateVerityNode()
	end)
	self.editneed:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.verityid == 2 then
			self.verityid = nil
		else
			self.verityid = 2
		end

		self:updateVerityNode()
	end)
end

function PopCommunityFilterLayer:updateVerityNode()
	if not self.verityid then
		self.veritynodes[1]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
		self.veritynodes[2]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
		self.veritynodes[1]:getChildByName("name"):setColor(var_0_10.off)
		self.veritynodes[2]:getChildByName("name"):setColor(var_0_10.off)
	elseif self.verityid == 1 then
		self.veritynodes[1]:loadTextures(var_0_12.on, nil, var_0_12.on, var_0_5)
		self.veritynodes[2]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
		self.veritynodes[1]:getChildByName("name"):setColor(var_0_10.on)
		self.veritynodes[2]:getChildByName("name"):setColor(var_0_10.off)
	else
		self.veritynodes[1]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
		self.veritynodes[2]:loadTextures(var_0_12.on, nil, var_0_12.on, var_0_5)
		self.veritynodes[1]:getChildByName("name"):setColor(var_0_10.off)
		self.veritynodes[2]:getChildByName("name"):setColor(var_0_10.on)
	end
end

function PopCommunityFilterLayer:updateSortUpDownNode()
	if not self.sortdownup then
		self.sortnode1[1]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
		self.sortnode1[2]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
		self.sortnode1[1]:getChildByName("name"):setColor(var_0_10.off)
		self.sortnode1[2]:getChildByName("name"):setColor(var_0_10.off)
	elseif self.sortdownup == 1 then
		self.sortnode1[1]:loadTextures(var_0_12.on, nil, var_0_12.on, var_0_5)
		self.sortnode1[2]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
		self.sortnode1[1]:getChildByName("name"):setColor(var_0_10.on)
		self.sortnode1[2]:getChildByName("name"):setColor(var_0_10.off)
	else
		self.sortnode1[1]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
		self.sortnode1[2]:loadTextures(var_0_12.on, nil, var_0_12.on, var_0_5)
		self.sortnode1[1]:getChildByName("name"):setColor(var_0_10.off)
		self.sortnode1[2]:getChildByName("name"):setColor(var_0_10.on)
	end
end

function PopCommunityFilterLayer:updateSorTypeNode()
	for iter_25_0 = 1, #self.sortnode2 do
		if iter_25_0 == self.sorttype then
			self.sortnode2[iter_25_0]:loadTextures(var_0_12.on, nil, var_0_12.on, var_0_5)
			self.sortnode2[iter_25_0]:getChildByName("name"):setColor(var_0_10.on)
		else
			self.sortnode2[iter_25_0]:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
			self.sortnode2[iter_25_0]:getChildByName("name"):setColor(var_0_10.off)
		end
	end
end

function PopCommunityFilterLayer:initLableLayer()
	self.ListViewlable:removeAllChildren()
	self.ListViewlable:setItemsMargin(20)

	self.labs = {}

	for iter_26_0, iter_26_1 in ipairs(family_tag_data) do
		local var_26_0 = self.items:clone()

		var_26_0.id = iter_26_1.id

		var_26_0:getChildByName("Button_50"):getChildByName("Label_52"):setString(iter_26_1.des)

		var_26_0:getChildByName("Button_50").id = iter_26_1.id

		if self.labels and next(self.labels) then
			local var_26_1 = false

			for iter_26_2, iter_26_3 in pairs(self.labels) do
				if iter_26_3 == var_26_0.id then
					var_26_1 = true
				end
			end

			var_26_0:getChildByName("Button_50").selet = var_26_1 and 1 or 0
		else
			var_26_0:getChildByName("Button_50").selet = 0
		end

		if var_26_0:getChildByName("Button_50").selet == 1 then
			var_26_0:getChildByName("Button_50"):loadTextures(var_0_12.on, nil, var_0_12.on, var_0_5)
			var_26_0:getChildByName("Button_50"):getChildByName("Label_52"):setColor(var_0_10.on)
		else
			var_26_0:getChildByName("Button_50"):loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
			var_26_0:getChildByName("Button_50"):getChildByName("Label_52"):setColor(var_0_10.off)
		end

		var_26_0:getChildByName("Button_50"):addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_27_0.selet = arg_27_0.selet == 1 and 0 or 1

			if arg_27_0.selet == 1 then
				arg_27_0:loadTextures(var_0_12.on, nil, var_0_12.on, var_0_5)
				arg_27_0:getChildByName("Label_52"):setColor(var_0_10.on)
			else
				arg_27_0:loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
				arg_27_0:getChildByName("Label_52"):setColor(var_0_10.off)
			end
		end)
		table.insert(self.labs, var_26_0)
		self.ListViewlable:pushBackCustomItem(var_26_0)
	end
end

function PopCommunityFilterLayer:updateMedalTableViewPanel()
	if not self.tableview1 or not self.labledata then
		return
	end

	local var_28_0, var_28_1 = GetTableViewShowCellIdx(self.tableview1, {
		cellsize = cc.size(var_0_7, var_0_8),
		maxcount = self:getCurDataListLen()
	})

	for iter_28_0 = var_28_0, var_28_1 do
		self.tableview1:updateCellAtIndex(iter_28_0)
	end
end

function PopCommunityFilterLayer:getCurDataListLen()
	local var_29_0 = math.ceil(#self.labledata / 4)

	if var_29_0 < 3 then
		var_29_0 = 3
	end

	return var_29_0
end

function PopCommunityFilterLayer:createLableNode()
	return (self.items:clone())
end

function PopCommunityFilterLayer:checklableIsSelect(arg_31_1)
	if not self.labels or not next(self.labels) then
		return false
	end

	local var_31_0 = false

	for iter_31_0, iter_31_1 in ipairs(self.labels) do
		if arg_31_1 == iter_31_1 then
			var_31_0 = true

			break
		end
	end

	return var_31_0
end

function PopCommunityFilterLayer:deletTableData(arg_32_1)
	if not self.labels or not next(self.labels) or not arg_32_1 then
		return
	end

	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(self.labels) do
		if iter_32_1 ~= arg_32_1 then
			table.insert(var_32_0, iter_32_1)
		end
	end

	print("self.labels", dump(var_32_0))

	self.labels = var_32_0
end

function PopCommunityFilterLayer:initLableTableView()
	self.tableview1:registerScriptHandler(function(arg_36_0, arg_36_1)
		return var_0_7, var_0_8
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableview1:registerScriptHandler(function(arg_34_0, arg_34_1)
		local var_34_0 = arg_34_0:dequeueCell()

		if not var_34_0 then
			var_34_0 = cc.TableViewCell:create()

			var_34_0:setName("cell_node_" .. arg_34_1)

			local var_34_1 = 4

			for iter_34_0 = 1, 4 do
				local var_34_2 = self:createLableNode()

				var_34_2:setName("sp_" .. iter_34_0)
				var_34_2:setPosition(var_0_9[iter_34_0])

				var_34_2:getChildByName("Button_50").selectindex = var_34_1 * arg_34_1 + iter_34_0

				var_34_2:getChildByName("Button_50"):setSwallowTouches(false)
				var_34_2:getChildByName("Button_50"):getChildByName("Label_52"):setString("")
				var_34_2:getChildByName("Button_50"):addTouchEventListener(function(arg_35_0, arg_35_1)
					if arg_35_1 ~= ccui.TouchEventType.ended then
						return
					end

					if not self:checklableIsSelect(arg_35_0.selectindex) then
						table.insert(self.labels, arg_35_0.selectindex)
					else
						self:deletTableData(arg_35_0.selectindex)
					end

					self:updateMedalTableViewPanel()
				end)

				if self.labledata[var_34_1 * arg_34_1 + iter_34_0] then
					local var_34_3 = self.labledata[var_34_1 * arg_34_1 + iter_34_0].des or nil

					if var_34_3 then
						var_34_2:getChildByName("Button_50"):getChildByName("Label_52"):setString(var_34_3)
						var_34_2:setVisible(true)

						var_34_2:getChildByName("Button_50").selectindex = var_34_1 * arg_34_1 + iter_34_0
						var_34_2.index = var_34_1 * arg_34_1 + iter_34_0

						goto label_34_0
					end
				end

				var_34_2:setVisible(false)

				::label_34_0::

				if self:checklableIsSelect(var_34_1 * arg_34_1 + iter_34_0) then
					var_34_2:getChildByName("Button_50"):loadTextures(var_0_12.on, nil, var_0_12.on, var_0_5)
				else
					var_34_2:getChildByName("Button_50"):loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
				end

				var_34_0:addChild(var_34_2)
			end
		else
			local var_34_4 = 4

			for iter_34_1 = 1, 4 do
				local var_34_5 = var_34_0:getChildByName("sp_" .. iter_34_1)

				if self.labledata[var_34_4 * arg_34_1 + iter_34_1] then
					local var_34_6 = self.labledata[var_34_4 * arg_34_1 + iter_34_1].des or nil

					if var_34_6 then
						var_34_5:getChildByName("Button_50"):getChildByName("Label_52"):setString(var_34_6)
						var_34_5:setVisible(true)

						var_34_5:getChildByName("Button_50").selectindex = var_34_4 * arg_34_1 + iter_34_1
						var_34_5.index = var_34_4 * arg_34_1 + iter_34_1

						goto label_34_1
					end
				end

				var_34_5:setVisible(false)

				::label_34_1::

				if self:checklableIsSelect(var_34_4 * arg_34_1 + iter_34_1) then
					var_34_5:getChildByName("Button_50"):loadTextures(var_0_12.on, nil, var_0_12.on, var_0_5)
				else
					var_34_5:getChildByName("Button_50"):loadTextures(var_0_12.off, nil, var_0_12.off, var_0_5)
				end
			end
		end

		return var_34_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableview1:registerScriptHandler(function(arg_37_0, arg_37_1)
		return self:getCurDataListLen()
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableview1:reloadData()
end

function PopCommunityFilterLayer:initBg(arg_38_1)
	local var_38_0 = ccui.Layout:create()

	var_38_0:setTouchEnabled(true)
	var_38_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_38_0:setAnchorPoint(cc.p(0, 0))
	var_38_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_38_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_38_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_38_0:setOpacity(0)
	var_38_0:setCascadeOpacityEnabled(false)
	self:addChild(var_38_0, -1)

	local var_38_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_38_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_38_1:setPositionX(var_38_0:getContentSize().width / 2)
	var_38_1:setPositionY(var_38_0:getContentSize().height / 2)
	var_38_0:addChild(var_38_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_39_0)
		self:addChild(arg_39_0, -2)
		arg_39_0:setPositionY(arg_39_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_38_1)
		var_38_0:setOpacity(102)
		var_38_0:setTouchEnabled(false)
	end)
end

function PopCommunityFilterLayer:exit(arg_40_1)
	self.hideActions.shrinkVertical(self, function()
		if self.callback then
			self.callback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
