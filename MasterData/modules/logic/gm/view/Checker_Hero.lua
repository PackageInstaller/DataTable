-- chunkname: @modules/logic/gm/view/Checker_Hero.lua

module("modules.logic.gm.view.Checker_Hero", package.seeall)

local Checker_Hero = class("Checker_Hero", Checker_Base)

Checker_Hero.Type = {
	Live2d = 1,
	Spine = 0
}

local s_characterSkinCOs = {}
local s_skinResPath2SkinId = {}

for _, v in ipairs(lua_skin.configList) do
	local skinId = v.id
	local characterId = v.characterId

	if not string.nilorempty(v.verticalDrawing) then
		local resPath = ResUrl.getRolesPrefabStory(v.verticalDrawing)

		s_skinResPath2SkinId[resPath] = skinId
	end

	if not string.nilorempty(v.live2d) then
		local resPath = ResUrl.getLightLive2d(v.live2d)

		s_skinResPath2SkinId[resPath] = skinId
	end

	s_characterSkinCOs[characterId] = s_characterSkinCOs[characterId] or {}

	table.insert(s_characterSkinCOs[characterId], v)
end

local function _characterVoiceCO(heroId)
	return lua_character_voice.configDict[heroId]
end

local function _characterSkinCO(heroId, skinId)
	return s_characterSkinCOs[heroId][skinId]
end

local function _resPathToSkinId(resPath)
	local basename = string.match(resPath, ".+/([^/]*%.%w+)$")
	local skinId = string.match(basename, "(%w+)")

	return assert(tonumber(skinId), "invalid resPath: " .. resPath)
end

local function _isValidSkinVoiceCO(CO, skinId)
	if not CO or not skinId then
		return false
	end

	local skins = CO.skins

	if string.nilorempty(skins) then
		return false
	end

	return string.find(skins, skinId)
end

local function _getInfoFromObj_SpineOrL2dObj(obj)
	local cname = obj.class.__cname

	if cname == "GuiSpine" or cname == "LightSpine" then
		return Checker_Hero.Type.Spine, obj, obj:getResPath()
	elseif cname == "GuiLive2d" or cname == "LightLive2d" then
		return Checker_Hero.Type.Live2d, obj, obj:getResPath()
	end
end

local function _getInfoFromObj_ModelAgent(modelAgent)
	local obj = modelAgent._curModel

	if not obj then
		return
	end

	return _getInfoFromObj_SpineOrL2dObj(obj)
end

local function _getInfoFromObj(obj)
	if not obj then
		return
	end

	local cname = obj.class.__cname

	if cname ~= "GuiModelAgent" and false then
		-- block empty
	end

	return _getInfoFromObj_ModelAgent(obj)
end

function Checker_Hero:ctor(heroId)
	Checker_Base.ctor(self)
	self:reset(heroId)
end

function Checker_Hero:reset(heroId)
	self._heroId = heroId
	self._heroCO = HeroConfig.instance:getHeroCO(heroId)
	self._resPath = ""
	self._skinId = false
end

function Checker_Hero:_logError(preStr)
	preStr = preStr or ""

	return string.format("%s%s(%s)", preStr, self:heroName(), tostring(self:heroId()))
end

function Checker_Hero:exec(obj, heroId)
	if heroId then
		self:reset(heroId)
	end

	local type, inst, resPath = _getInfoFromObj(obj)

	self._resPath = resPath

	if not type or not inst then
		self:_logError("[_getInfoFromObj]: ")

		return
	end

	if type == Checker_Hero.Type.Spine then
		self:_onExec_Spine(inst)
	elseif type == Checker_Hero.Type.Live2d then
		self:_onExec_Live2d(inst)
	else
		assert(false, "unsupported Checker_Hero.Type!! type=" .. tostring(type))
	end
end

function Checker_Hero:_onExec_Spine(inst)
	assert(false, "please override this function!")
end

function Checker_Hero:_onExec_Live2d(inst)
	assert(false, "please override this function!")
end

function Checker_Hero:heroId()
	return self._heroId
end

function Checker_Hero:heroCO()
	return self._heroCO
end

function Checker_Hero:heroName()
	return self._heroCO.name
end

function Checker_Hero:resPath()
	return self._resPath
end

function Checker_Hero:skinId()
	assert(not string.nilorempty(self._resPath), "please call exec first!!")

	self._skinId = self._skinId or s_skinResPath2SkinId[self._resPath] or _resPathToSkinId(self._resPath)

	return self._skinId
end

function Checker_Hero:characterVoiceCO()
	return _characterVoiceCO(self._heroId)
end

function Checker_Hero:characterSkinCO()
	local skinId = self:skinId()

	return _characterSkinCO[self._heroId][skinId]
end

function Checker_Hero:skincharacterVoiceCOList()
	local skinId = self:skinId()

	return self:_skincharacterVoiceCOList(skinId)
end

function Checker_Hero:heroMO()
	return HeroModel.instance:getByHeroId(self._heroId)
end

function Checker_Hero:heroMOSkinId()
	local MO = self:heroMO()

	if MO then
		return MO.skin
	end
end

function Checker_Hero:heroMOSkinCO()
	local skinId = self:heroMOSkinId()

	if skinId then
		return _characterSkinCO[self._heroId][skinId]
	end
end

function Checker_Hero:heroMOSkincharacterVoiceCOList()
	return self:_skincharacterVoiceCOList(self:heroMOSkinId())
end

function Checker_Hero:_skincharacterVoiceCOList(skinId)
	local list = {}

	if not skinId then
		return list
	end

	local CO = self:characterVoiceCO()

	for audioId, v in pairs(CO) do
		if _isValidSkinVoiceCO(v, skinId) then
			table.insert(list, v)
		end
	end

	return list
end

return Checker_Hero
