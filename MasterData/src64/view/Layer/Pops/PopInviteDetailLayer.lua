PopInviteDetailLayer = class("PopInviteDetailLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Sprite.AvatarSprite")

local playermodel = require("model.playermodel")
local task_data = require("data.task_data")
local invite_manager = require("controller.invite_manager")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local LocalEvent = require("common.LocalEvent")
local var_0_6 = config._DEBUG and 0 or 1
local var_0_8 = "    最多可同时绑定8名班长，与已绑班长解除关系，\n不会重置任务进度及奖励。"
local var_0_9 = {
	"TopcostLayer/new_Junior.png",
	"TopcostLayer/new_Senior.png",
	"TopcostLayer/new_Univ.png",
	"TopcostLayer/new_master.png"
}

function PopInviteDetailLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopInviteDetailLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopInviteDetailLayer:init(arg_3_1)
	self:initData(arg_3_1)
	self:initUI()
	self:registerEvents()
	self:show()
end

function PopInviteDetailLayer.initData(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_0.invites = arg_4_1.invites or {}
	end
end

function PopInviteDetailLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopInviteDetailLayer.json" or "PopInviteDetailLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootNode)

	self.rootpanel = self.rootNode:getChildByName("panelRoot")

	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(GameDisplay.size.height / 2)
	self.rootpanel:setTouchEnabled(false)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)
	self.panelMain:setPositionY(self.panelMain:getPositionY() + 50)

	self.labelInfo = Utility:seekChildByName(self.panelMain, "labelInfo")

	self.labelInfo:setString(var_0_8)

	self.listViewInvites = self.panelMain:getChildByName("listViewInvites")
	self.panelItem = self.panelMain:getChildByName("panelItem")

	self.panelItem:retain()
	self.panelItem:removeFromParent()
end

function PopInviteDetailLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.rootNode, handler(self, self.hide))
	EventManager:subscribe(self, EventManager.EVENT_IDS.TERMINATE_BIND_UID, handler(self, self.handleTerminateBindUID))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_INVITE_INFO, handler(self, self.handleGetInviteInfo))
end

function PopInviteDetailLayer:updateLayout()
	self.listViewInvites:removeAllChildren()

	for iter_7_0, iter_7_1 in ipairs(self.invites) do
		local var_7_0 = self.panelItem:clone()

		self:updateOnePanelItem(var_7_0, iter_7_1)
		self.listViewInvites:pushBackCustomItem(var_7_0)
	end

	self.listViewInvites:doLayout()
	self.listViewInvites:jumpToPercentVertical(0)
end

function PopInviteDetailLayer:updateOnePanelItem(arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:getChildByName("imgHead")
	local var_8_1 = arg_8_1:getChildByName("labelLevel")
	local var_8_2 = arg_8_1:getChildByName("labelPower")
	local var_8_3 = arg_8_1:getChildByName("labelTime")
	local var_8_4 = arg_8_1:getChildByName("btnCall")
	local var_8_5 = arg_8_1:getChildByName("labelCall")

	Utility:addClickEventListener(arg_8_1:getChildByName("btnTerminate"), handler(self, self.onBtnTerminate), arg_8_2)
	Utility:addClickEventListener(var_8_4, handler(self, self.onBtnCall), arg_8_2)
	arg_8_1:getChildByName("imgClass"):loadTexture(var_0_9[arg_8_2.class], var_0_6)
	self:updateHeadImg(arg_8_1, arg_8_2.head_sculpture)
	arg_8_1:getChildByName("labelName"):setString(arg_8_2.name)
	var_8_1:setString("等级." .. arg_8_2.level)
	var_8_1:setVisible(false)
	var_8_2:setString(global_trans_number(arg_8_2.fightpower))
	var_8_2:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)

	local var_8_6 = require("controller.friend_system_manager"):dealTheOnlineTime(arg_8_2.lastlogin)

	var_8_3:setString(var_8_6)

	if arg_8_2.lastlogin == "-1" then
		var_8_3:setColor(cc.c3b(0, 255, 18))
	else
		var_8_3:setColor(cc.c3b(133, 133, 133))
	end

	if var_8_6 == L_FRIEND_SYSTEM.max_onlie then
		var_8_4:setVisible(true)
		var_8_5:setVisible(true)
	else
		var_8_4:setVisible(false)
		var_8_5:setVisible(false)
	end
end

function PopInviteDetailLayer.updateHeadImg(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_2 or not arg_9_1 then
		return
	end

	local var_9_0 = AvatarSprite:create(tonumber(arg_9_2))

	var_9_0:setScale(0.6)
	Utility:replaceNodeByNode(arg_9_1, "imgHead", var_9_0)
	var_9_0:setPosition(26, 24)
end

function PopInviteDetailLayer.onBtnCall(arg_10_0, arg_10_1, arg_10_2)
	if config.packagechannel ~= "feiyu" then
		global_ShowBlockWords("已复制召回码，快去分享给小伙伴吧")
	end

	invite_manager:share()
end

function PopInviteDetailLayer.onBtnTerminate(arg_11_0, arg_11_1, arg_11_2)
	LayerManager:pushInLayer("PopDoLayer", {
		surecallback = function()
			EventManager:requestTerminateBindUID(arg_11_2.playerid)
		end,
		labels = {
			button = "确 认",
			isHorizonalCenter = true,
			titleImage = "title_default.png",
			des = "是否解除绑定关系，解除后与该玩家不能再次绑定"
		}
	})
end

function PopInviteDetailLayer.onEnter(arg_13_0)
	EventManager:requestGetInviteInfo()
end

function PopInviteDetailLayer:onExit()
	self.panelItem:release()
	EventManager:unsubscribe(self)
end

function PopInviteDetailLayer:show()
	self.showActions.extendVertical(self)
end

function PopInviteDetailLayer:hide()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopInviteDetailLayer.handleTerminateBindUID(arg_18_0, arg_18_1)
	if not arg_18_1 then
		return
	end

	if arg_18_1.result == 1 then
		EventManager:requestGetInviteInfo()
	end
end

function PopInviteDetailLayer:handleGetInviteInfo(arg_19_1)
	if not arg_19_1 then
		return
	end

	if arg_19_1.result == 1 then
		self.invites = arg_19_1.inviteplayer or {}

		self:updateLayout()
	end
end
