-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/view/PassLevelUpMediator.lua

PassLevelUpMediator = class("PassLevelUpMediator", DmPopupViewMediator, _M)

PassLevelUpMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function PassLevelUpMediator:initialize()
	super.initialize(self)
end

function PassLevelUpMediator:dispose()
	super.dispose(self)
end

function PassLevelUpMediator:onRegister()
	super.onRegister(self)
end

function PassLevelUpMediator:mapEventListeners()
	return
end

function PassLevelUpMediator:onRemove()
	super.onRemove(self)
end

function PassLevelUpMediator:enterWithData(data)
	AudioEngine:getInstance():playRoleEffect("Se_Effect_Levelup", false)
	self:createUI(data)
end

function PassLevelUpMediator:createUI(data)
	self._mainpanel = self:getView():getChildByName("mainpanel")

	self._mainpanel:setLocalZOrder(2)

	local panel = self._mainpanel:getChildByName("panel")

	panel:setOpacity(0)

	local levelPanel = self._mainpanel:getChildByName("levelPanel")

	levelPanel:setVisible(false)

	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:addTo(self._mainpanel:getChildByName("animNode")):offset(0, -15)
	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local title1 = cc.Label:createWithTTF(Strings:get("Pass_UI39"), CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(Strings:get("Pass_UI63"), TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)

	if data.type == 2 then
		panel:setVisible(false)
		title1:setString(Strings:get("Heros_LvUp"))
		title2:setString(Strings:get("UITitle_EN_Dengjitisheng"))
		anim:addCallbackAtFrame(14, function()
			levelPanel:setVisible(true)
			levelPanel:fadeIn({
				time = 0.2
			})
		end)

		local level1 = levelPanel:getChildByFullName("level_1")
		local level2 = levelPanel:getChildByFullName("level_2")

		level1:setString(data.level1)
		level2:setString(data.level2)
	else
		local nomal = panel:getChildByFullName("icon.nomal")
		local excellent = panel:getChildByFullName("icon.excellent")

		if data.showType == 1 then
			nomal:setVisible(true)
			excellent:setVisible(false)
		end

		if data.showType == 2 then
			nomal:setVisible(false)
			excellent:setVisible(true)
		end

		anim:addCallbackAtFrame(14, function()
			panel:fadeIn({
				time = 0.2
			})
		end)
	end
end
