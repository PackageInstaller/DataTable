-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/service/HeroService.lua

HeroService = class("HeroService", Service, _M)

function HeroService:initialize()
	super.initialize(self)
end

function HeroService:dispose()
	super.dispose(self)
end

function HeroService:requestHeroList(params, blockUI, callback)
	local request = self:newRequest(11001, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestHeroStrengthenData(params, blockUI, callback)
	local request = self:newRequest(11013, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestHeroLvlUp(params, blockUI, callback)
	local request = self:newRequest(11005, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestHeroStarUp(params, blockUI, callback)
	local request = self:newRequest(11003, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestSelectStarUpReward(params, blockUI, callback)
	local request = self:newRequest(11019, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestHeroEvolutionUp(params, blockUI, callback)
	local request = self:newRequest(11004, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestHeroReborn(params, blockUI, callback)
	local request = self:newRequest(11022, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestHeroSkillLvlUp(params, blockUI, callback)
	local request = self:newRequest(11006, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestHeroSkillUpTen(params, blockUI, callback)
	local request = self:newRequest(11016, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestHeroAdvanceLvlUp(params, blockUI, callback)
	local request = self:newRequest(11015, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestHeroSoulLvlUp(params, blockUI, callback)
	local request = self:newRequest(11010, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestHeroSoulLvlUpByDiamond(params, blockUI, callback)
	local request = self:newRequest(11011, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestRelationUnlock(params, blockUI, callback)
	local request = self:newRequest(11008, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestRelationLvlUp(params, blockUI, callback)
	local request = self:newRequest(11009, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:shareHeroRelation(params, blockUI, callback)
	local request = self:newRequest(11010, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:findHeroRelationShare(params, blockUI, callback)
	local request = self:newRequest(11011, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestSoulUpByItem(params, blockUI, callback)
	local request = self:newRequest(11013, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestSoulUpByDiamond(params, blockUI, callback)
	local request = self:newRequest(11014, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestSoulUnlock(params, blockUI, callback)
	local request = self:newRequest(11012, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestHeroAwake(params, blockUI, callback)
	local request = self:newRequest(11020, params, callback)

	self:sendRequest(request, blockUI)
end

function HeroService:requestHeroIdentityAwake(params, blockUI, callback)
	local request = self:newRequest(11021, params, callback)

	self:sendRequest(request, blockUI)
end
