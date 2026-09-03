-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/club/ClubBuildingMainComponent.lua

ClubBuildingMainComponent = class("ClubBuildingMainComponent", BuildingMainComponent)

function ClubBuildingMainComponent:initialize(data)
	super.initialize(self, data)
end

function ClubBuildingMainComponent:enterWithData(userInfo)
	super.enterWithData(self)

	local layer_normal = self:getView():getChildByFullName("main.Layer_normal")
	local Layer_buy = self:getView():getChildByFullName("main.Layer_buy")
	local layer_Operation = self:getView():getChildByFullName("main.layer_Operation")
	local Node_comfort = self:getView():getChildByFullName("main.Node_comfort")
	local Node_resouse = self:getView():getChildByFullName("main.Node_resouse")
	local effect_node = self:getView():getChildByFullName("main.effect_node")
	local cluber_info_node = self:getView():getChildByFullName("main.cluber_info_node")

	layer_normal:setVisible(false)
	Layer_buy:setVisible(false)
	layer_Operation:setVisible(false)
	Node_comfort:setVisible(false)
	Node_resouse:setVisible(false)
	effect_node:setVisible(false)
	cluber_info_node:setVisible(true)
	self:setupBackBtn()
end

function ClubBuildingMainComponent:refreshClubInfo(userInfo)
	if userInfo then
		local icon = self:getView():getChildByFullName("main.cluber_info_node.Node_icon")
		local Text_name = self:getView():getChildByFullName("main.cluber_info_node.Text_name")
		local Text_lv = self:getView():getChildByFullName("main.cluber_info_node.Text_lv")
		local Text_fight = self:getView():getChildByFullName("main.cluber_info_node.Image_fight_bg.Text_fight")

		Text_name:setString(userInfo.nickname)
		Text_lv:setString("Lv." .. userInfo.level)
		Text_fight:setString(userInfo.combat)

		local headIcon = IconFactory:createPlayerIcon({
			frameStyle = 3,
			clipType = 1,
			headFrameScale = 0.415,
			id = userInfo.headId,
			size = cc.size(100, 100),
			headFrameId = userInfo.headFrame
		})

		headIcon:addTo(icon)
	end
end

function ClubBuildingMainComponent:setupBackBtn()
	local topinfo_node = self:getView():getChildByFullName("main.topinfo_node")
	local children = topinfo_node:getChildren()

	for k, v in pairs(children) do
		v:setVisible(false)
	end

	self:showBackBtn()
end
