-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/base/RoleFactory.lua

RoleFactory = RoleFactory or {}

local DEFAULT_MASTER_SP_RES = "asset/master/Master_XueZhan/masterbattlepic_Master_XueZhan.png"
local DEFAULT_HERO_SP_RES = "asset/heros/YFZZhu/headpic_YFZZhu.png"

RolePicTypeType = {
	kHead = "kMiddleHead",
	kPortrait = "kFullRole"
}
RoleMediaType = {
	kSPHead = "battlepic",
	kBattleHead = "portraitpic",
	kSmallHead = "headpic",
	kMiddleHead = "battlepic",
	kLargeHead = "headpic",
	kFullRole = "portraitpic"
}
RoleAnimType = {
	kStand = "stand",
	kStand1 = "stand1",
	kHurt = "hurt",
	kWin = "win",
	kDebut = "debut",
	kRun = "run",
	kWalk = "walk",
	kFail = "fail"
}
MasterRoleMediaType = {
	kSPHead = "masterbattlepic",
	kBattleHead = "masterportraitpic",
	kSmallHead = "headpic",
	kMiddleHead = "headpic",
	kLargeHead = "headpic",
	kFullRole = "battle"
}

local function getModelConfig(modelId)
	return ConfigReader:getRecordById("RoleModel", tostring(modelId))
end

function RoleFactory:getHeroResPath(roleMediaType, modelId)
	modelId = tostring(modelId)

	return "asset/heros/" .. modelId .. "/" .. roleMediaType .. "_" .. modelId .. ".png"
end

function RoleFactory:getMasterResPath(roleMediaType, modelId, isMaster)
	modelId = tostring(modelId)

	return "asset/master/" .. modelId .. "/" .. roleMediaType .. "_" .. modelId .. ".png"
end

function RoleFactory:createRolePicPath(modelId, rolePicTypeType)
	if ConfigReader:getRecordById("HeroBase", tostring(modelId)) then
		return RoleFactory:getHeroResPath(RoleMediaType[rolePicTypeType] or rolePicTypeType, modelId), false
	elseif ConfigReader:getRecordById("MasterBase", tostring(modelId)) then
		return RoleFactory:getMasterResPath(MasterRoleMediaType[rolePicTypeType] or rolePicTypeType, modelId), true
	end
end

function RoleFactory:createRolePic(modelId, rolePicType, style)
	if modelId == nil then
		return
	end

	local rolePic, modelId = self:createRolePicImg(modelId, rolePicType)
	local layout = ccui.Layout:create()

	layout:setTouchEnabled(false)
	layout:setAnchorPoint(cc.p(0.5, 0.5))

	local size = rolePic:getContentSize()

	layout:setContentSize(cc.size(size.width, size.height))
	rolePic:setAnchorPoint(0.5, 1)
	rolePic:addTo(layout):center(layout:getContentSize())
	layout:setSwallowTouches(false)

	if style and style.mask then
		local colorIndex = maskDefaulColorIndex

		rolePic:setColor(cc.c4b(colorIndex, colorIndex, colorIndex, maskIntensity))
	end

	function layout:setMaskOpacity(maskOpacity)
		local colorIndex = maskOpacity or maskDefaulColorIndex

		rolePic:setColor(cc.c4b(colorIndex, colorIndex, colorIndex, maskIntensity))
	end

	function layout:runMaskFadeAction(time, maskOpacity)
		rolePic:runAction(cc.TintTo:create(time, cc.c4b(maskOpacity, maskOpacity, maskOpacity, maskIntensity)))
	end

	return layout
end

function RoleFactory:createRolePicImg(modelId, rolePicType)
	local resPath, isMaster = self:createRolePicPath(modelId, rolePicType)
	local rolePic = cc.Sprite:create(resPath)

	if not rolePic then
		if isMaster then
			return cc.Sprite:create(DEFAULT_MASTER_SP_RES), modelId
		end

		return cc.Sprite:create(DEFAULT_HERO_SP_RES), modelId
	end

	return rolePic, modelId
end

function RoleFactory:createClippingPortraitPic(modelId, style)
	style = style or {}

	local node = cc.Node:create()

	if style.size then
		if not style.size then
			local size = cc.size(860, 500)
			local layout = ccui.Layout:create()

			layout:setTouchEnabled(true)
			layout:setSwallowTouches(false)
			layout:setContentSize(size)
			layout:setClippingEnabled(true)
			layout:addTo(node):center(node:getContentSize())
			layout:setLocalZOrder(3)

			local rolePic = self:createRolePic(modelId, RolePicTypeType.kPortrait, style)

			rolePic:setAnchorPoint(0.5, 1)

			if not style.extraX then
				if not style.extraY then
					local extraY = 0

					rolePic:addTo(layout):posite(layout:getContentSize().width / 2 + style.extraX, layout:getContentSize().height + extraY)

					if style.offSetConfig then
						local offSetConfig = style.offSetConfig

						if offSetConfig and offSetConfig[modelId] then
							local offSet = offSetConfig[modelId].offset

							if offSet then
								rolePic:offset(offSet.x, offSet.y)
							end

							rolePic:setScale(offSetConfig[modelId].scale)
						end
					end

					return node
				end
			end
		end
	end
end

local pathPrefix = "asset/anim/"

function RoleFactory:createRoleAnim(modelId)
	local config = getModelConfig(modelId)

	assert(config ~= nil, modelId .. "'s config not found")

	local id = config.Model

	if ConfigReader:getRecordById("HeroBase", tostring(modelId)) then
		local jsonPath = pathPrefix .. id .. ".skel"

		if not cc.FileUtils:getInstance():isFileExist(jsonPath) then
			jsonPath = "asset/anim/YFZZhu.skel"
		end

		return (sp.SkeletonAnimation:create(jsonPath))
	elseif ConfigReader:getRecordById("MasterBase", tostring(modelId)) then
		local jsonPath = pathPrefix .. id .. ".skel"

		if not cc.FileUtils:getInstance():isFileExist(jsonPath) then
			jsonPath = "asset/anim/Master_LieSha.skel"
		end

		return (sp.SkeletonAnimation:create(jsonPath))
	end
end

local roleAnimTag = 123

function RoleFactory:createRolePortraitAnim(modelId, animType, style)
	style = style or {}
	animType = animType or "loop"

	local baseNode = cc.Node:create()

	function baseNode:runAction(animType)
		return
	end

	function baseNode:getAnim()
		return self:getChildByTag(roleAnimTag)
	end

	local anim = self:createRoleAnim(modelId)

	if anim then
		anim:addTo(baseNode, 1, roleAnimTag):center(baseNode:getContentSize()):setName("anim")
		anim:setPosition(cc.p(-10, -640))

		local scale = 1.1

		if portraitOffSet and portraitOffSet[modelId] then
			local offset = portraitOffSet[modelId]

			anim:setPosition(cc.p(-10, offset.posY))

			scale = offset.scale or scale
		end

		anim:setScale(scale)

		if style.mask then
			anim:setColor(cc.c4b(maskDefaulColorIndex, maskDefaulColorIndex, maskDefaulColorIndex, 200))
		elseif not style.stopAnim then
			anim:playAnimation(0, animType, true)
		end
	else
		local rolePic = self:createRolePic(modelId, RolePicType.kPortrait, style)

		rolePic:addTo(baseNode, 1, roleAnimTag):center(baseNode:getContentSize()):offset(0, -30)
		rolePic:setScale(0.8)
	end

	return baseNode
end

function RoleFactory:createRoleBehavioralAnim(modelId, animType, style)
	if ConfigReader:getRecordById("HeroBase", tostring(modelId)) then
		return RoleFactory:createHeroAnimation(modelId, animType, style)
	elseif ConfigReader:getRecordById("MasterBase", tostring(modelId)) then
		return RoleFactory:createMasterAnimation(modelId, animType, style)
	end
end

function RoleFactory:createHeroAnimation(modelId, animType, style)
	style = style or {}
	animType = animType or "stand"

	local config = getModelConfig(modelId)

	assert(config ~= nil, modelId .. "'s config not found")

	local id = config.Model
	local jsonPath = pathPrefix .. id .. ".skel"

	if not cc.FileUtils:getInstance():isFileExist(jsonPath) then
		id = "YFZZhu"
	end

	local spAni, jsonPath = RoleFactory:createRoleAnimation(id, animType, style)

	return spAni, jsonPath
end

function RoleFactory:createMasterAnimation(modelId, animType, style)
	style = style or {}
	animType = animType or "stand"

	local config = getModelConfig(modelId)

	assert(config ~= nil, modelId .. "'s config not found")

	local id = config.Model
	local jsonPath = pathPrefix .. id .. ".skel"

	if not cc.FileUtils:getInstance():isFileExist(jsonPath) then
		id = "Master_LieSha"
	end

	local spAni, jsonPath = RoleFactory:createRoleAnimation(id, animType, style)

	return spAni, jsonPath
end

function RoleFactory:createRoleAnimation(modelId, animType, style)
	style = style or {}
	animType = animType or "stand"

	local jsonPath = pathPrefix .. modelId .. ".skel"

	if not cc.FileUtils:getInstance():isFileExist(jsonPath) then
		jsonPath = pathPrefix .. "YFZZhu" .. ".skel"
	end

	if not style.once then
		local once = false
		local spAni = sp.SkeletonAnimation:create(jsonPath)

		spAni:playAnimation(0, animType, not once)

		return spAni, jsonPath
	end
end

local attrShowOrder = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Attr_ShowOrder", "content")
local attrName = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_SkillAttrName", "content")

function getAttName()
	local atts = {}

	for key, order in pairs(attrShowOrder) do
		if attrName[key] then
			atts[order] = attrName[key]
		end
	end

	return atts
end

function getAttNumber(target)
	local combat, attrData = target:getCombat()
	local atts = {}
	local attsIcon = {}
	local func = {
		ATK = attrData.attack,
		DEF = attrData.defense,
		HP = attrData.hp,
		SPEED = attrData.speed,
		CRITRATE = attrData.critRate,
		UNCRITRATE = attrData.uncritRate,
		CRITSTRG = attrData.critStrg,
		BLOCKRATE = attrData.blockRate,
		UNBLOCKRATE = attrData.unblockRate,
		BLOCKSTRG = attrData.blockStrg,
		HURTRATE = attrData.hurtRate,
		UNHURTRATE = attrData.unhurtRate,
		ABSORPTION = attrData.absorption,
		REFLECTION = attrData.reflection
	}

	for key, order in pairs(attrShowOrder) do
		if attrName[key] then
			if func[key] then
				local attrNum = func[key]

				if AttributeCategory:getAttNameAttend(key) ~= "" then
					attrNum = attrNum * 100 .. "%"
				end

				atts[order] = attrNum
				attsIcon[order] = AttrTypeImage[key]
			else
				atts[order] = 0
				attsIcon[order] = ""
			end
		end
	end

	return atts, attsIcon
end

function getAttrNameByType(type)
	return Strings:get(attrName[type])
end

local attrTSoulShowOrder = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Attr_TimeSoul_ShowOrder", "content")

function getTSoulAttNumber(attrData)
	local atts = {}

	for key, order in pairs(attrTSoulShowOrder) do
		if attrName[key] then
			if attrData[key] then
				local attrNum = attrData[key]

				if AttributeCategory:getAttNameAttend(key) ~= "" then
					attrNum = attrNum * 100 .. "%"
				end

				atts[order] = {
					num = attrNum,
					icon = AttrTypeImage[key],
					type = key,
					attrName = getAttrNameByType(key)
				}
			else
				atts[order] = {}
			end
		end
	end

	local ret = {}

	for i, v in ipairs(atts) do
		if v.num then
			ret[#ret + 1] = v
		end
	end

	return ret
end
