PopBestTeammatesLayer = class("PopBestTeammatesLayer", function()
	return PopBaseLayer:create()
end)

local playermodel = require("model.playermodel")
local servant_data = require("data.servant_data")
local horcrux_data = require("data.horcrux_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local LocalEvent = require("common.LocalEvent")
local var_0_8 = require("controller.servant_rank_manager").getInstance()
local var_0_9 = var_0_8.FIGHT_TYPE
local var_0_10 = var_0_8.RANK_TYPE
local var_0_11 = var_0_8.PVP_TYPE
local var_0_13 = config._DEBUG and 0 or 1
local var_0_14 = "role/"
local var_0_15 = {
	"servantrank/" .. "img_rare_r.png",
	"servantrank/" .. "img_rare_sr.png",
	"servantrank/" .. "img_rare_ur.png",
	"servantrank/" .. "img_rare_mr.png",
	"servantrank/" .. "img_rare_sp.png"
}

function PopBestTeammatesLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopBestTeammatesLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopBestTeammatesLayer:init(arg_3_1)
	self:initData(arg_3_1)
	self:initUI()
	self:registerEvents()
	self:show()
end

function PopBestTeammatesLayer.initData(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_0.showServantId = arg_4_1.servantId or 20820
	end

	if arg_4_1 then
		arg_4_0.rankType = arg_4_1.rankType or var_0_10.NORMAL
	end

	if arg_4_1 then
		arg_4_0.fightType = arg_4_1.fightType or var_0_9.PVE
	end

	if arg_4_1 then
		arg_4_0.mode = arg_4_1.mode or 0
	end

	if arg_4_1 then
		arg_4_0.chapter = arg_4_1.chapter or 0
	end

	if arg_4_1 then
		arg_4_0.pvpType = arg_4_1.pvpType or var_0_11.ARENA
	end

	arg_4_0.teammates = {}
end

function PopBestTeammatesLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopBestTeammatesLayer.json" or "PopBestTeammatesLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootNode)

	self.rootpanel = self.rootNode:getChildByName("rootPanel")

	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(GameDisplay.size.height / 2)
	self.rootpanel:setTouchEnabled(false)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)

	self.panelItem = self.panelMain:getChildByName("panelItem")

	self.panelItem:retain()
	self.panelItem:removeFromParent()

	self.listViewTeammates = self.panelMain:getChildByName("listViewTeammates")
	self.imgName = self.panelMain:getChildByName("imgName")
	self.labelName = self.imgName:getChildByName("labelName")

	self.labelName:setFontName("fonts/newkj.ttf")
	self.labelName:setString(major_factor_data[servant_data[self.showServantId].major].easy_name)

	self.imgRole = self.panelMain:getChildByName("imgRole")
	self.imgTitleRole = self.panelMain:getChildByName("imgServantBg"):getChildByName("imgTitleRole")
end

function PopBestTeammatesLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.rootNode, handler(self, self.hide))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_SERVANT_BEST_TEAMMATE, handler(self, self.handleServantBestTeammate))
end

function PopBestTeammatesLayer:updateLayout()
	self.imgRole:loadTexture(var_0_14 .. model_data[servant_data[self.showServantId].modelid].role_image .. ".png")
	self.imgRole:setAnchorPoint(0.5, 0.5)
	self.imgRole:setScale(0.7)
	self.imgRole:setVisible(false)
	self.imgTitleRole:loadTexture(ROLE_PORTRAIT_PATH .. model_data[servant_data[self.showServantId].modelid].portrait_image .. ".png")
	self.imgTitleRole:setScale(1.1)

	if not model_data[servant_data[self.showServantId].modelid].levelresult_offset_x then
		-- block empty
	end

	if not model_data[servant_data[self.showServantId].modelid].levelresult_offset_y then
		-- block empty
	end

	self.imgRole:setPosition(180, 320)
	self:updateListView()
end

function PopBestTeammatesLayer:generateTeammates(arg_8_1)
	self.teammates = {}

	local var_8_0 = var_0_8:getRankDatas(self.rankType, self.mode, self.chapter)

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		self.teammates[#self.teammates + 1] = var_0_8:queryRankDataByServantId(var_8_0, iter_8_1)
	end
end

function PopBestTeammatesLayer:updateListView()
	self.listViewTeammates:removeAllChildren()

	for iter_9_0, iter_9_1 in ipairs(self.teammates) do
		self.listViewTeammates:pushBackCustomItem((self:createOnePanelItem(iter_9_1)))
	end
end

function PopBestTeammatesLayer:createOnePanelItem(arg_10_1)
	local var_10_0 = self.panelItem:clone()
	local var_10_1 = var_10_0:getChildByName("imgBorder")
	local var_10_2 = var_10_0:getChildByName("imgServant")
	local var_10_3 = var_10_0:getChildByName("imgHorcrux")
	local var_10_4 = var_10_0:getChildByName("labelScore")
	local var_10_5 = var_10_0:getChildByName("imgCareer")
	local var_10_6 = var_10_0:getChildByName("imgRare")
	local var_10_7 = var_10_0:getChildByName("labelName")

	var_10_7:setFontName("fonts/number.ttf")
	var_10_7:setFontSize(25)
	var_10_4:setFontName("fonts/number.ttf")
	var_10_4:setString("" .. (arg_10_1.score or 0))

	local var_10_8 = arg_10_1.servantId
	local var_10_9

	if arg_10_1.horcruxId and arg_10_1.horcruxId ~= 0 then
		var_10_9 = arg_10_1.horcruxId or 30517005

		if not var_10_8 or not servant_data[var_10_8] or not servant_data[var_10_8].modelid then
			print("miss servant mode data", var_10_8)
		elseif model_data[servant_data[var_10_8].modelid] then
			var_10_2:loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[servant_data[var_10_8].modelid].cute_Q .. ".png")
			var_10_6:loadTexture(var_0_15[servant_data[var_10_8].roll_rarity or 1], var_0_13)
			var_10_5:loadTexture(CAREER_ICON[servant_data[var_10_8].career .. "_" .. global_get_model_attr(servant_data[var_10_8].modelid)], var_0_13)
			var_10_7:setString(major_factor_data[servant_data[var_10_8].major].easy_name)
		end
	end

	print("miss mode id", servant_data[var_10_8].modelid)

	if not var_10_9 or not horcrux_data[var_10_9] or not horcrux_data[var_10_9].model then
		print("miss horcrux mode data", var_10_9)
	elseif model_data[horcrux_data[var_10_9].model].cute_Q then
		var_10_3:loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[horcrux_data[var_10_9].model].cute_Q .. ".png")
		self:updateHorcruxStars(var_10_0, 5)
	else
		print("miss mode id", horcrux_data[var_10_9].model)
	end

	return var_10_0
end

function PopBestTeammatesLayer.updateHorcruxStars(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:getChildByName("listViewStars")

	var_11_0:setClippingEnabled(false)
	var_11_0:setItemModel((var_11_0:getChildByName("imgStar")))
	var_11_0:removeAllChildren()

	for iter_11_0 = 1, arg_11_2 - 1 do
		var_11_0:pushBackDefaultItem()
	end
end

function PopBestTeammatesLayer:onEnter()
	EventManager:requestGetServantBestTeammate(self.fightType, self.mode, self.chapter, self.pvpType, self.showServantId, 10)
end

function PopBestTeammatesLayer:onExit()
	self.panelItem:release()
	EventManager:unsubscribe(self)
end

function PopBestTeammatesLayer:show()
	self.showActions.extendVertical(self)
end

function PopBestTeammatesLayer:hide()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopBestTeammatesLayer:handleServantBestTeammate(arg_17_1)
	if not arg_17_1 then
		return
	end

	if arg_17_1.result == 1 then
		self:generateTeammates(arg_17_1.servantids or {})
		self:updateLayout()
	else
		global_ShowBlockWords("参数错误")
	end
end
