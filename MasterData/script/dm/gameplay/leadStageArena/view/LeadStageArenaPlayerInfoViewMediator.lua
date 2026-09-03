-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/view/LeadStageArenaPlayerInfoViewMediator.lua

LeadStageArenaPlayerInfoViewMediator = class("LeadStageArenaPlayerInfoViewMediator", DmPopupViewMediator, _M)

LeadStageArenaPlayerInfoViewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
LeadStageArenaPlayerInfoViewMediator:has("_loginSystem", {
	is = "r"
}):injectWith("LoginSystem")

local kBtnHandlers = {}

function LeadStageArenaPlayerInfoViewMediator:initialize()
	super.initialize(self)
end

function LeadStageArenaPlayerInfoViewMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function LeadStageArenaPlayerInfoViewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function LeadStageArenaPlayerInfoViewMediator:userInject()
	return
end

function LeadStageArenaPlayerInfoViewMediator:enterWithData(data)
	self:bindWidget("bg.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("StageArena_MainUI13"),
		bgSize = {
			width = 600,
			height = 360
		}
	})
	self:initRoleInfo(data)
end

function LeadStageArenaPlayerInfoViewMediator:initRoleInfo(data)
	self._bg = self:getView():getChildByName("bg")

	local playerIconBg = self._bg:getChildByName("icon_top")
	local level = self._bg:getChildByName("level")
	local name = self._bg:getChildByFullName("name")
	local serverName = self._bg:getChildByFullName("txt_serverName")
	local oldCoinNum = self._bg:getChildByFullName("txt_oldCoinNum")
	local oldCointImg = self._bg:getChildByFullName("Image_1")
	local rank = self._bg:getChildByFullName("txt_rankNum")
	local headIcon = IconFactory:createPlayerIcon({
		frameStyle = 3,
		clipType = 1,
		headFrameScale = 0.415,
		id = data:getHead(),
		size = playerIconBg:getContentSize(),
		headFrameId = data:getHeadFrame()
	})

	headIcon:setScale(1.15)
	headIcon:addTo(playerIconBg):center(playerIconBg:getContentSize())
	level:setString(Strings:get("Common_LV_Text") .. data:getLevel())
	name:setString(data:getNickName())

	local idStr = string.split(data:getRid(), "_")[2]
	local serverInfo = self._loginSystem:getLogin():getServerBySec(idStr)
	local s = Strings:get("StageArena_MainUI14", {
		servername = serverInfo:getName()
	})

	serverName:setString(serverInfo:getName())

	local icon = ccui.ImageView:create(leadStageArenaPicPath, ccui.TextureResType.plistType)

	oldCointImg:removeAllChildren()
	icon:setScale(0.4)
	icon:addTo(oldCointImg):offset(25, 22)
	oldCoinNum:setString(data:getOldCoin())

	local rankIndex = data:getRankIndex()

	rank:setString(rankIndex > 0 and rankIndex or Strings:get("StageArena_PopUpUI05"))
end

function LeadStageArenaPlayerInfoViewMediator:onClickBack()
	self:close()
end
