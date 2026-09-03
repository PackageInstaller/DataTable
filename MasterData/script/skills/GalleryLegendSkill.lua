-- chunkname: @/tmp/or_skill/lua_compile/GalleryLegendSkill.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.HeroLegend_ToMasterHurtRateUp = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				else
					local buffeft1 = global.SpecialNumericEffect(_env, "+Master_DmgExtra_hurtrate", {
						"+Normal",
						"+Normal"
					}, this.HurtRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "HeroLegend_ToMasterHurtRateUp",
						timing = 0,
						limit = 1,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}
	_M.__all__.HeroLegend_AfterActATKRateUp = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.MASTER(_env, _env.ACTOR) then
					-- block empty
				else
					local buffeft1 = global.NumericEffect(_env, "+atkrate", {
						"+Normal",
						"+Normal"
					}, this.AtkRateFactor)

					global.ApplyBuff(_env, _env.ACTOR, {
						duration = 99,
						group = "HeroLegend_AfterActATKRateUp",
						timing = 0,
						limit = 5,
						tags = {
							"NUMERIC",
							"BUFF",
							"UNDISPELLABLE",
							"UNSTEALABLE"
						}
					}, {
						buffeft1
					})
				end
			end)

			return _env
		end
	}

	return _M
end
