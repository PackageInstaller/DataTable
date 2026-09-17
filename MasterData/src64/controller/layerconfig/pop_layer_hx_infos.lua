return {
	PopActivityArtRewardLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityArtRewardLayer:create(...))
		end,
		textures = {
			"Activity_halloween"
		}
	},
	PopBuyPackageDirectLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBuyPackageDirectLayer:create(...))
		end,
		textures = {}
	},
	PopNoviceRechargeLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopNoviceRechargeLayer:create(...))
		end,
		textures = {
			"PopNoviceRechargeLayer"
		}
	},
	PromoteRechargeLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PromoteRechargeLayer:create(...))
		end
	},
	RulesPacksCollectionLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (RulesPacksCollectionLayer:create(...))
		end,
		textures = {
			"PopReturnBackPacksLayer"
		}
	},
	PopUmaruScoreUpLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopUmaruScoreUpLayer:create(...))
		end,
		textures = {
			"SubstitutionLayer"
		}
	},
	PopOpenChoosegiftLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopOpenChoosegiftLayer:create(...))
		end
	},
	PopFlopBuyLayer_137 = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopFlopBuyLayer_137:create(...))
		end,
		textures = {
			"PopUmaruTwist"
		}
	},
	PopTvtNewSeasonLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTvtNewSeasonLayer:create(...))
		end,
		textures = {
			"PopTvtRecordLayer"
		}
	},
	PopTvtNewSeasonMainLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTvtNewSeasonMainLayer:create(...))
		end,
		textures = {
			"PopTvtNewSeasonLayer"
		}
	},
	TowerDefenceDetailLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.TowerDefenceDetailLayer")

			return (TowerDefenceDetailLayer:create(...))
		end,
		textures = {
			"adventurenewlayer",
			"Array"
		}
	},
	ExpeditionDetailLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.ExpeditionDetailLayer")

			return (ExpeditionDetailLayer:create(...))
		end,
		textures = {
			"adventurenewlayer",
			"Array"
		}
	},
	PopTowerDefenceResultLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTowerDefenceResultLayer:create(...))
		end,
		textures = {
			"ChapterSettlement"
		}
	},
	PopExpeditionResultLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopExpeditionResultLayer:create(...))
		end,
		textures = {
			"ChapterSettlement"
		}
	},
	PopShowSkinLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Pops.PopShowSkinLayer"):create(...))
		end,
		textures = {
			"MarketLayer"
		}
	},
	OfflineEarningsLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.OfflineEarningsLayer")

			return (OfflineEarningsLayer:create(...))
		end,
		textures = {
			"OfflineEarnings",
			"Offline_Return"
		}
	},
	ExploreOfferPopLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Pops.ExploreOfferPopLayer"):create(...))
		end
	},
	DormVisitLayer = {
		hideUI = true,
		createLayer = function(...)
			return (require("view.Layer.DormVisitLayer"):create(...))
		end,
		bgm = FAVOR_BGM,
		bg = DORM_BG,
		textures = {
			"Dormitory",
			"room_widget",
			"DormVisitLayer"
		}
	},
	PopServantAdvanceLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopServantAdvanceLayer")

			return (PopServantAdvanceLayer:create(...))
		end,
		textures = {
			"PopServantAdvanceLayer"
		}
	}
}
