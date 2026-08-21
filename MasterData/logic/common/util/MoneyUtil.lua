-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/MoneyUtil.lua

module("logic.common.util.MoneyUtil", package.seeall)

local MoneyUtil = {}
local MoneyShowType = CommEnum.MoneyShowType
local CurrencyCodeEnum = CommEnum.CurrencyCodeEnum
local CurrencySrcEnum = CommEnum.CurrencyItemSrc

MoneyUtil.MaxEnergyColor = "#FFFFFF"
MoneyUtil.CurEnergyNormalColor = "#FFFFFF"
MoneyUtil.CurEnergyReachMaxColor = "#FFFFFF"

local moneyInfos = {
	[MoneyShowType.DefaultHideType] = {
		defaultHide = true,
		moneyCodes = {}
	},
	[MoneyShowType.MoneyGeneralShowType] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			},
			{
				code = CurrencyCodeEnum.YtjjCode
			},
			{
				code = CurrencyCodeEnum.LzbCode
			}
		}
	},
	[MoneyShowType.BackpackShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.YtjjCode
			},
			{
				code = CurrencyCodeEnum.LzbCode
			}
		}
	},
	[MoneyShowType.BackpackRecycleShowType] = {
		moneyCodes = {
			{
				code = 1100014
			}
		}
	},
	[MoneyShowType.BackpackRecycleEchoShowType] = {
		moneyCodes = {
			{
				code = 1100007
			},
			{
				code = 1100008
			}
		}
	},
	[MoneyShowType.DungeonShowType] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			}
		}
	},
	[MoneyShowType.OnlyMoneyShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.LzbCode
			}
		}
	},
	[MoneyShowType.OnlyDiamondShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.YtjjCode
			}
		}
	},
	[MoneyShowType.OnlySkinShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.YtjjCode
			}
		}
	},
	[MoneyShowType.OnlyDiamondEnergyType] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			},
			{
				code = CurrencyCodeEnum.YtjjCode
			}
		}
	},
	[MoneyShowType.HouseShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.LzbCode
			},
			{
				code = CurrencyCodeEnum.XwjsCode
			}
		}
	},
	[MoneyShowType.OnlyEnergyShowType] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			}
		}
	},
	[MoneyShowType.OnlyEnergyWithOutAddBtn] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.TlCode
			}
		}
	},
	[MoneyShowType.EnergyWithHint] = {
		moneyCodes = {
			{
				hint = true,
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			}
		}
	},
	[MoneyShowType.HealthExchangeShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.TlCode
			},
			{
				code = CurrencyCodeEnum.YtjjCode
			}
		}
	},
	[MoneyShowType.RoomUpgradeShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.LzbCode
			},
			{
				jumpBtnPassEvent = false,
				code = CurrencyCodeEnum.XwjzjtCode
			},
			{
				jumpBtnPassEvent = false,
				code = CurrencyCodeEnum.XwjzhjCode
			},
			{
				jumpBtnPassEvent = false,
				code = CurrencyCodeEnum.XwjzclCode
			}
		}
	},
	[MoneyShowType.MallShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.YtjjCode
			},
			{
				code = CurrencyCodeEnum.HcjjCode
			}
		}
	},
	[MoneyShowType.OnlyHcjj] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.HcjjCode
			}
		}
	},
	[MoneyShowType.OnlyInspirationS] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.InspirationSCode
			}
		}
	},
	[MoneyShowType.OnlyInspirationA] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.InspirationACode
			}
		}
	},
	[MoneyShowType.InspirationAS] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.InspirationACode
			},
			{
				code = CurrencyCodeEnum.InspirationSCode
			}
		}
	},
	[MoneyShowType.DiamondMoneyShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.YtjjCode
			},
			{
				code = CurrencyCodeEnum.LzbCode
			}
		}
	},
	[MoneyShowType.DiamondJsjjShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.JsjjCode
			},
			{
				code = CurrencyCodeEnum.YtjjCode
			}
		}
	},
	[MoneyShowType.FurniturePartAndMoneyShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.LzbCode
			},
			{
				jumpBtnPassEvent = false,
				code = 1706001
			}
		}
	},
	[MoneyShowType.HouseRoomActiveShowType1] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.LzbCode
			},
			{
				jumpBtnPassEvent = false,
				code = 1702001
			}
		}
	},
	[MoneyShowType.HouseRoomActiveShowType2] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.LzbCode
			},
			{
				jumpBtnPassEvent = false,
				code = 1702002
			}
		}
	},
	[MoneyShowType.HouseRoomActiveShowType3] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.LzbCode
			},
			{
				jumpBtnPassEvent = false,
				code = 1702003
			}
		}
	},
	[MoneyShowType.ProtomerModelUpgradeShowType1] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.LzbCode
			},
			{
				jumpBtnPassEvent = false,
				code = 1705001
			},
			{
				jumpBtnPassEvent = false,
				code = CurrencyCodeEnum.ProtomerModulePointCode
			}
		}
	},
	[MoneyShowType.ProtomerModelUpgradeShowType2] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.LzbCode
			},
			{
				jumpBtnPassEvent = false,
				code = 1705001
			},
			{
				jumpBtnPassEvent = false,
				code = CurrencyCodeEnum.ProtomerModulePointCode
			}
		}
	},
	[MoneyShowType.ProtomerModelUpgradeShowType3] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.LzbCode
			},
			{
				jumpBtnPassEvent = false,
				code = 1705001
			},
			{
				jumpBtnPassEvent = false,
				code = CurrencyCodeEnum.ProtomerModulePointCode
			}
		}
	},
	[MoneyShowType.HousePoachingShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.XwjzclCode
			},
			{
				code = CurrencyCodeEnum.LzbCode
			}
		}
	},
	[MoneyShowType.AirStudioChallengeShowType] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.AirStudioChallengeNum
			}
		}
	},
	[MoneyShowType.AirStudioChallengeShowTypeWithHint] = {
		moneyCodes = {
			{
				hint = true,
				hideJumpBtn = true,
				code = CurrencyCodeEnum.AirStudioChallengeNum
			}
		}
	},
	[MoneyShowType.AirStudioStoreShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.AirSutdioStoreCoinCode
			}
		}
	},
	[MoneyShowType.MallRoguelikeShowType] = {
		moneyCodes = {
			{
				code = 1100013
			}
		}
	},
	[MoneyShowType.RoguelikeEquipShowType] = {
		moneyCodes = {
			{
				code = 1100013
			}
		}
	},
	[MoneyShowType.RogueVendingMachineShowType] = {
		moneyCodes = {
			{
				hideJumpBtn = true,
				code = CurrencyCodeEnum.RoguelikeCoinCode
			}
		}
	},
	[MoneyShowType.MaterialChapter1001] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			},
			{
				code = CurrencyCodeEnum.LzbCode
			}
		}
	},
	[MoneyShowType.MaterialChapter1002] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			},
			{
				code = 1003004
			},
			{
				code = 1003003
			},
			{
				code = 1003002
			},
			{
				code = 1003001
			}
		}
	},
	[MoneyShowType.MaterialChapter1003] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			},
			{
				code = 1004080
			},
			{
				code = 1004079
			},
			{
				code = 1004078
			},
			{
				code = 1004077
			}
		}
	},
	[MoneyShowType.MaterialChapter1004] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			},
			{
				code = 1004084
			},
			{
				code = 1004083
			},
			{
				code = 1004082
			},
			{
				code = 1004081
			}
		}
	},
	[MoneyShowType.MaterialChapter1005] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			},
			{
				code = 1004088
			},
			{
				code = 1004087
			},
			{
				code = 1004086
			},
			{
				code = 1004085
			}
		}
	},
	[MoneyShowType.MaterialChapter1006] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			},
			{
				code = 1004092
			},
			{
				code = 1004091
			},
			{
				code = 1004090
			},
			{
				code = 1004089
			}
		}
	},
	[MoneyShowType.MaterialChapter1007] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			},
			{
				code = 1004096
			},
			{
				code = 1004095
			},
			{
				code = 1004094
			},
			{
				code = 1004093
			}
		}
	},
	[MoneyShowType.MaterialChapter1008] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			},
			{
				code = 1004100
			},
			{
				code = 1004099
			},
			{
				code = 1004098
			},
			{
				code = 1004097
			}
		}
	},
	[MoneyShowType.MaterialChapter2001] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			}
		}
	},
	[MoneyShowType.MaterialChapter2002] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			}
		}
	},
	[MoneyShowType.MaterialChapter2003] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			}
		}
	},
	[MoneyShowType.MaterialChapter2003] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.TlCode
			}
		}
	},
	[MoneyShowType.LotteryHeroShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.JsjjCode
			},
			{
				code = CurrencyCodeEnum.YtjjCode
			}
		}
	},
	[MoneyShowType.LotteryEchoShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.EchoJsjjCode
			},
			{
				code = CurrencyCodeEnum.YtjjCode
			}
		}
	},
	[MoneyShowType.HouseSpeedUpShowType] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.XwjsCode
			}
		}
	},
	[MoneyShowType.EquipIntensify] = {
		moneyCodes = {
			{
				code = CurrencyCodeEnum.LzbCode
			}
		}
	},
	[MoneyShowType.ClawDollCoin] = {
		moneyCodes = {
			{
				addBtn = true,
				code = CurrencyCodeEnum.ClawDollCoin
			}
		}
	}
}

function MoneyUtil.getMoneyInfoByShowType(moneyShowType)
	local info = moneyInfos[moneyShowType]

	if not info then
		printWarn(string.format("无法找到moneyShowType[%s],将返回默认值", moneyShowType))

		info = moneyInfos[MoneyShowType.MoneyGeneralShowType]
	end

	table.sort(info.moneyCodes, function(dataA, dataB)
		if dataA.code == CurrencyCodeEnum.TlCode and dataB.code ~= CurrencyCodeEnum.TlCode then
			return false
		elseif dataA.code ~= CurrencyCodeEnum.TlCode and dataB.code == CurrencyCodeEnum.TlCode then
			return true
		end

		local coA = BackpackConfig.instance:getItemInfoByItemId(dataA.code)
		local coB = BackpackConfig.instance:getItemInfoByItemId(dataB.code)

		if coA.quality ~= coB.quality then
			return coA.quality < coB.quality
		end

		return coA.id < coB.id
	end)

	return info
end

function MoneyUtil.getMoneyInfoList(codeList)
	local moneyCodes = {}

	if codeList then
		for i = #codeList, 1, -1 do
			table.insert(moneyCodes, {
				code = codeList[i]
			})
		end
	end

	return moneyCodes
end

function MoneyUtil.setMoneyIcon(img, code)
	local function _getIconName(nameStr)
		return tostring(nameStr) .. "0"
	end

	if CurrencySrcEnum[code] then
		IconLoader.setSprite(img, IconType.Skinlib, CurrencySrcEnum[code])
	else
		local itemCo = BackpackConfig.instance:getItemInfoByItemId(code)

		if itemCo then
			img.sprite = nil

			IconLoader.setSprite(img, IconType.Skinlib, _getIconName(itemCo.icon))

			if not img.sprite then
				printWarn(string.format("图集currency_dynamic没有货币资源，货币Code：%s", code))

				local dynIcon = Astral.ImageDynIcon.Get(img.gameObject)

				dynIcon:ClearImage()
				IconLoader.setSprite(img, IconType.ItemIcon, itemCo.icon)
			end
		else
			img.sprite = nil

			IconLoader.setSprite(img, IconType.Skinlib, _getIconName(code))

			if not img.sprite then
				printWarn(string.format("图集currency_dynamic没有货币资源，货币Code：%s", code))

				local dynIcon = Astral.ImageDynIcon.Get(img.gameObject)

				dynIcon:ClearImage()
				IconLoader.setSprite(img, IconType.ItemIcon, code)
			end
		end
	end
end

return MoneyUtil
