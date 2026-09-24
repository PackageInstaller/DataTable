-- chunkname: @modules/logic/college/model/rpcmo/CollegeCharacterBoxMo.lua

module("modules.logic.college.model.rpcmo.CollegeCharacterBoxMo", package.seeall)

local CollegeCharacterBoxMo = pureTable("CollegeCharacterBoxMo")

function CollegeCharacterBoxMo:init(data)
	self.characters, self.charactersMap = GameUtil.rpcInfosToListAndMap(data.characters, CollegeCharacterMo, "uid", self.charactersMap)
end

function CollegeCharacterBoxMo:getCharacterMo(uid)
	return self.charactersMap[uid]
end

function CollegeCharacterBoxMo:updateCharacterMos(data)
	local newMos

	for i, v in ipairs(data) do
		local character = self.charactersMap[v.uid]

		if character then
			character:init(v)
		else
			character = CollegeCharacterMo.New()

			character:init(v)
			CollegeController.instance:showToast(GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_toast_character_add"), character.co.name))

			self.charactersMap[v.uid] = character

			table.insert(self.characters, character)

			newMos = newMos or {}

			table.insert(newMos, character)
		end
	end

	return newMos
end

function CollegeCharacterBoxMo:removeCharacter(uids)
	for i, v in ipairs(uids) do
		local character = self.charactersMap[v]

		if character then
			CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.RoleDismiss)
			CollegeController.instance:showToast(GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_toast_character_remove"), character.co.name))
			tabletool.removeValue(self.characters, character)

			self.charactersMap[v] = nil
		end
	end
end

function CollegeCharacterBoxMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeCharacterBoxMo" then
		return false
	end

	local isSame = true

	if #self.characters ~= #otherMo.characters then
		isSame = false

		logError(string.format("CollegeCharacterBoxMo compareWith characters count not same: %s >> %s", #self.characters, #otherMo.characters))
	else
		for i = 1, #self.characters do
			local otherCharacterMo = otherMo.charactersMap[self.characters[i].uid]

			if not otherCharacterMo or not self.characters[i]:compareWith(otherCharacterMo) then
				isSame = false

				logError(string.format("CollegeCharacterBoxMo compareWith characters not same: uid=%s", self.characters[i].uid))

				break
			end
		end
	end

	return isSame
end

return CollegeCharacterBoxMo
