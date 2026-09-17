local var_0_0 = {
	BGSprite = {
		x = 650,
		y = 248
	},
	MainSprite = {
		x = 580,
		y = 220
	},
	InfoBG = {
		x = 567,
		y = 105
	},
	NameLabel = {
		x = 163,
		y = 48
	},
	DescLabel = {
		x = 576,
		y = 48
	},
	Star1 = {
		scale = 1,
		x = 14,
		y = 10
	},
	Star2 = {
		scale = 0.4,
		x = 37,
		y = 14
	},
	Star3 = {
		scale = 0.5,
		x = 23,
		y = 92
	},
	Star4 = {
		scale = 1,
		x = 917,
		y = 94
	},
	Star5 = {
		scale = 0.4,
		x = 893,
		y = 96
	},
	Star6 = {
		scale = 0.5,
		x = 914,
		y = 7
	}
}
local var_0_1 = {
	BGLayer = function(self)
		local var_1_0 = self:getChildByName("BGLayer")

		if not var_1_0 then
			var_1_0 = cc.NodeGrid:create()

			var_1_0:setName("BGLayer")
			self:addChild(var_1_0)

			local var_1_1 = cc.Sprite:create("ui/showNewRole/showNewRoleBG.png")

			var_1_1:setAnchorPoint(cc.p(0, 0))
			var_1_0:addChild(var_1_1)
			var_1_0:runAction(cc.Sequence:create(cc.SplitRows:create(0.6, 9):reverse(), cc.CallFunc:create(function()
				self:exeAni("BGSprite")
			end)))
		else
			var_1_0:runAction(cc.CallFunc:create(function()
				self:exeAni("BGSprite")
			end))
		end
	end,
	BGSprite = function(self)
		local var_4_0 = self:getChildByName("BGSprite")

		if not var_4_0 then
			var_4_0 = cc.Sprite:create()

			var_4_0:setName("BGSprite")
			self:addChild(var_4_0)
		end

		var_4_0:setTexture(self.imageName)
		var_4_0:setPosition(var_0_0.BGSprite.x, var_0_0.BGSprite.y)
		var_4_0:setScale(3)
		var_4_0:setOpacity(0)

		local var_4_1 = cc.Sprite:create(self.expressionImageName)

		var_4_1:setAnchorPoint(cc.p(0, 0))
		var_4_0:addChild(var_4_1)
		var_4_0:setCascadeOpacityEnabled(true)
		var_4_0:runAction(cc.Sequence:create(cc.Spawn:create(cc.ScaleTo:create(0.3, 1), cc.FadeTo:create(0.3, 126)), cc.CallFunc:create(function()
			self:exeAni("MainSprite")
		end)))
	end,
	MainSprite = function(self)
		local var_6_0 = self:getChildByName("MainSprite")

		if not var_6_0 then
			var_6_0 = cc.Sprite:create()

			var_6_0:setName("MainSprite")
			self:addChild(var_6_0)
		end

		var_6_0:setTexture(self.imageName)
		var_6_0:setPosition(var_0_0.MainSprite.x, var_0_0.MainSprite.y)
		var_6_0:setScale(0.2)
		var_6_0:setOpacity(0)

		local var_6_1 = cc.Sprite:create(self.expressionImageName)

		var_6_1:setAnchorPoint(cc.p(0, 0))
		var_6_0:addChild(var_6_1)
		var_6_0:setCascadeOpacityEnabled(true)
		var_6_0:runAction(cc.Sequence:create(cc.Spawn:create(cc.ScaleTo:create(0.4, 0.7), cc.FadeTo:create(0.2, 255)), cc.CallFunc:create(function()
			self:exeAni("InfoBG")
		end)))
	end,
	InfoBG = function(self)
		local var_8_0 = self:getChildByName("GridNode")

		if not var_8_0 then
			var_8_0 = cc.NodeGrid:create()

			var_8_0:setName("GridNode")
			var_8_0:setZOrder(1)
			self:addChild(var_8_0)
		end

		infoBGNode = var_8_0:getChildByName("InfoBG")

		if not infoBGNode then
			infoBGNode = cc.Scale9Sprite:create("ui/showNewRole/huode_bg.png")

			infoBGNode:setName("InfoBG")
			infoBGNode:setPreferredSize(cc.size(930, 100))
			infoBGNode:setCapInsets(cc.rect(75, 50, 1, 1))
			infoBGNode:setPosition(var_0_0.InfoBG.x, var_0_0.InfoBG.y)
			var_8_0:addChild(infoBGNode)
			var_8_0:runAction(cc.Sequence:create((cc.TurnOffTiles:create(1, cc.size(120, 120), 2):reverse())))
		end

		if not infoBGNode then
			return
		end

		infoBGNode:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			self:exeAni("NameLabel")
			self:exeAni("DescLabel")
			self:exeAni("ShowParticle")
			self:exeAni("ShowStar")
		end)))
	end,
	NameLabel = function(self)
		local var_10_0 = self:getChildByName("GridNode")

		if not var_10_0 then
			return
		end

		local var_10_1 = var_10_0:getChildByName("InfoBG")

		if not var_10_1 then
			return
		end

		local var_10_2 = var_10_1:getChildByName("NameLabel")

		if not var_10_2 then
			var_10_2 = cc.Label:createWithTTF("", "fonts/new1.ttf", 32, cc.size(150, 96), cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)

			var_10_2:setName("NameLabel")
			var_10_2:setZOrder(1)
			var_10_2:setPosition(var_0_0.NameLabel.x, var_0_0.NameLabel.y)
			var_10_1:addChild(var_10_2)
		end

		var_10_2:setString(self.roleName)
	end,
	DescLabel = function(self)
		local var_11_0 = self:getChildByName("GridNode")

		if not var_11_0 then
			return
		end

		local var_11_1 = var_11_0:getChildByName("InfoBG")

		if not var_11_1 then
			return
		end

		local var_11_2 = var_11_1:getChildByName("DescLabel")

		if not var_11_2 then
			var_11_2 = cc.Label:createWithTTF("", "fonts/new1.ttf", 20, cc.size(554, 96), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)

			var_11_2:setName("DescLabel")
			var_11_2:setZOrder(1)
			var_11_2:setPosition(var_0_0.DescLabel.x, var_0_0.DescLabel.y)
			var_11_1:addChild(var_11_2)
		end

		var_11_2:setString(self.roleDesc)
	end,
	ShowParticle = function(self)
		local var_12_0 = cc.ParticleSystemQuad:create("ui/showNewRole/particle_texture.plist")

		var_12_0:setPosition(SCREEN_WIDTH / 2, SCREEN_HEIGHT)
		self:addChild(var_12_0, 1)
	end,
	ShowStar = function(self)
		local var_13_0 = self:getChildByName("GridNode")

		if not var_13_0 then
			return
		end

		local var_13_1 = var_13_0:getChildByName("InfoBG")

		if not var_13_1 then
			return
		end

		if not var_13_1:getChildByName("Star1") then
			for iter_13_0 = 1, 6 do
				local var_13_2 = cc.Sprite:create("ui/showNewRole/star.png")

				var_13_2:setName("Star" .. iter_13_0)
				var_13_2:setZOrder(2)
				var_13_2:setScale(var_0_0["Star" .. iter_13_0].scale)
				var_13_2:setPosition(var_0_0["Star" .. iter_13_0].x, var_0_0["Star" .. iter_13_0].y)
				var_13_1:addChild(var_13_2)
			end
		end
	end
}

ShowNewRole = class("ShowNewRole", function()
	return cc.Layer:create()
end)

function ShowNewRole.create(arg_15_0)
	local var_15_0 = ShowNewRole.new()

	var_15_0:init()

	return var_15_0
end

function ShowNewRole.ctor(arg_16_0)
	setSwallowTouchesListenner(arg_16_0)
end

function ShowNewRole.init(arg_17_0)
	return
end

function ShowNewRole.exeAni(arg_18_0, arg_18_1)
	if not arg_18_1 then
		return
	end

	var_0_1[arg_18_1](arg_18_0)
end

function ShowNewRole:setNewRole(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if not arg_19_1 or not arg_19_2 or not arg_19_3 then
		return
	end

	if self.imageName == arg_19_1 or self.roleName == arg_19_2 or self.roleDesc == arg_19_3 then
		return
	end

	self.imageName = arg_19_1
	self.roleName = arg_19_2
	self.roleDesc = arg_19_3
	self.expressionImageName = arg_19_4

	self:exeAni("BGLayer")
end
