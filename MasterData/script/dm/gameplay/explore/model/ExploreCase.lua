-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/model/ExploreCase.lua

require("dm.gameplay.explore.model.ExploreCaseFactor")

ExploreCase = class("ExploreCase", objectlua.Object)

ExploreCase:has("_id", {
	is = "r"
})

function ExploreCase:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("MapCase", id)
end

function ExploreCase:getBeginDialogue()
	return self._config.BeginDialogue
end

function ExploreCase:getEndDialogue()
	return self._config.EndDialogue
end

function ExploreCase:getBeginStory()
	return self._config.BeginStory
end

function ExploreCase:getEndStory()
	return self._config.EndStory
end

function ExploreCase:getCaseType()
	return self._config.CaseType
end

function ExploreCase:getCaseFactor()
	local factor = self._config.CaseFactor

	if factor and factor.casefactor and type(factor.casefactor) ~= "table" then
		factor.casefactor = ExploreCaseFactor:new(factor.casefactor)
	end

	return factor
end

function ExploreCase:getBeginJournalDes()
	return self._config.BeginJournalDes
end

function ExploreCase:getEndJournalDes()
	return self._config.EndJournalDes
end
