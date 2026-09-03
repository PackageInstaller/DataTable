-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/model/ExploreCaseFactor.lua

ExploreCaseFactor = class("ExploreCaseFactor", objectlua.Object)

ExploreCaseFactor:has("_id", {
	is = "r"
})

function ExploreCaseFactor:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("MapCaseFactor", id)
end

function ExploreCaseFactor:getType()
	return self._config.Type
end

function ExploreCaseFactor:getEndDialogue()
	return self._config.EndDialogue
end

function ExploreCaseFactor:getTitle()
	return Strings:get(self._config.Title)
end

function ExploreCaseFactor:getDesc()
	return Strings:get(self._config.Desc)
end

function ExploreCaseFactor:getPic()
	return self._config.Pic
end

function ExploreCaseFactor:getReward()
	return self._config.Reward
end

function ExploreCaseFactor:getBpFactor()
	return self._config.BpFactor
end

function ExploreCaseFactor:getOrder()
	return self._config.Order
end

function ExploreCaseFactor:getOption()
	return self._config.Option
end

function ExploreCaseFactor:getBattleOption()
	return self._config.BattleOption
end

function ExploreCaseFactor:getQuickBattleOption()
	return self._config.QuickBattleOption
end

function ExploreCaseFactor:getNeedItem()
	return self._config.NeedItem
end

function ExploreCaseFactor:getNeedNum()
	return self._config.NeedNum
end

function ExploreCaseFactor:getCheckOption()
	return self._config.CheckOption
end

function ExploreCaseFactor:getCheckDes()
	return Strings:get(self._config.CheckDes)
end

function ExploreCaseFactor:getTag()
	return self._config.Tag
end
