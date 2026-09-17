SchoolAreaLayer = class("SchoolAreaLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local level_manager = require("controller.level_manager")
local bond_manager = require("controller.bond_manager")
local alert_manager = require("controller.alert_manager")
local community_system_manager = require("controller.community_system_manager")
local var_0_6 = config._DEBUG and 0 or 1

function SchoolAreaLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = SchoolAreaLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

local var_0_7 = {
	btn_dalao = {
		layerName = "",
		visible = false,
		fix_y = GameDisplay.fix_y
	},
	btn_fileRoomTips = {
		layerName = "SchoolFileLayer",
		visible = true,
		fix_y = GameDisplay.fix_y * 0.6
	},
	btn_deanOffice = {
		layerName = "NewSchoolDeanOfficeLayer",
		visible = true,
		fix_y = GameDisplay.fix_y * 0.6,
		lock = UNLOCK_SCHOOL_OFFICE
	},
	btn_memoryRoomTips = {
		layerName = "SchoolCinemaLayer",
		visible = true,
		fix_y = GameDisplay.fix_y * 1.1
	},
	btn_study = {
		layerName = "SchoolStudyLayer",
		visible = true,
		fix_y = -GameDisplay.fix_y * 0.3,
		lock = UNLOCK_SCHOOL_STUDY
	},
	btn_labRoomTips = {
		layerName = "LabMenuLayer",
		visible = true,
		fix_y = -GameDisplay.fix_y * 0.3,
		lock = UNLOCK_LAB_FACTORY
	},
	btn_trainRoomTips = {
		layerName = "SchoolTrainLayer",
		visible = true,
		fix_y = GameDisplay.fix_y,
		lock = UNLOCK_SCHOOL_TRAIN
	},
	btn_laboratoryRoom = {
		layerName = "LabMakeNewLayer",
		visible = false,
		fix_y = -GameDisplay.fix_y * 0.4,
		lock = UNLOCK_LAB
	},
	btn_afkLevel = {
		layerName = "AfkLevelLayer",
		visible = true,
		fix_y = GameDisplay.fix_y * 0.5,
		lock = UNLOCK_LAB
	},
	btn_community = {
		layerName = "joinCommunityLayer",
		visible = true,
		fix_y = GameDisplay.fix_y * 0.5,
		lock = UNLOCK_COMMAINMAINLAYE
	}
}

function SchoolAreaLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SchoolArea.json" or "SchoolArea.ExportJson")

	self:addChild(self.rootLayer, 1)
	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function SchoolAreaLayer:initUI()
	self:initBG()
	self:initBtns()
end

function SchoolAreaLayer:initBG()
	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_moveBG")

	self.bg:loadTexture(SCHOOL_BG)
end

function SchoolAreaLayer:initBtns()
	for iter_7_0, iter_7_1 in pairs(var_0_7) do
		local var_7_0 = self.rootLayer:getChildByName(iter_7_0)

		var_7_0:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_8_0.lock then
				if type(iter_7_1.lock) == "function" then
					iter_7_1.lock(true)

					return
				end

				if L_SCHOOL_AREA_LOCK[iter_7_0] then
					global_ShowBlockWords(string.format(L_SCHOOL_AREA_LOCK[iter_7_0], level_manager:formatModeChapterLevelByPlayerLevel(iter_7_1.lock)))

					return
				end
			end

			if iter_7_1.layerName == "joinCommunityLayer" then
				iter_7_1.layerName = community_system_manager:getInintJumpLayerName()
			end

			if not iter_7_1.pop then
				LayerManager:switchShowLayer(iter_7_1.layerName)
			else
				LayerManager:pushInLayer(iter_7_1.layerName)
			end

			AnalyticManager.school_area_getID({
				area_ID = iter_7_1.layerName
			})
		end)

		if iter_7_1.lock then
			if type(iter_7_1.lock) == "function" then
				if not iter_7_1.lock() then
					self:lockbtn(var_7_0)
				end
			elseif not level_manager:isPlayerPassLevel(iter_7_1.lock) then
				self:lockbtn(var_7_0)
			end
		end

		var_7_0:setVisible(iter_7_1.visible)
		var_7_0:setPositionY(var_7_0:getPositionY() + iter_7_1.fix_y)
	end
end

function SchoolAreaLayer.lockbtn(arg_9_0, arg_9_1)
	local var_9_0 = ccui.ImageView:create("schoolArea/btn_lock.png", var_0_6)

	var_9_0:setPosition(cc.p(arg_9_1:getContentSize().width / 2, arg_9_1:getContentSize().height / 2))
	arg_9_1:addChild(var_9_0)

	arg_9_1.lock = true
end
