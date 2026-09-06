-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/constdef/MatType.lua

module("logiccommon.common.constdef.MatType", package.seeall)

local MatType = {}

MatType.Cloth = 1
MatType.Title = 2
MatType.PokeBall = 3
MatType.PetPiece = 5
MatType.Item = 4
MatType.Decoration = 6
MatType.Equipment = 7
MatType.Coin = 8
MatType.DROP_ITEM = 9
MatType.ACTIVITY_ITEM = 10
MatType.ZooEgg = 12
MatType.HeadIcon = 13
MatType.HeadFrame = 14
MatType.Throne = 15
MatType.Hoshigami = 16
MatType.PET_SKIN = 17
MatType.StarGodPlus = 18
MatType.Bubble = 19
MatType.TimedItem = 20
MatType.Emoji = 21
MatType.EmojiPack = 22
MatType.HIRE_PET = 23
MatType.HolyStripe = 24
MatType.PetTitle = 25
MatType.ExpirableItem = 27
MatType.OpeningEffect = 28
MatType.HomePageBg = 29
MatType.NameFrame = 30
MatType.CutePet = 31
MatType.PlayerMessageSkin = 32
MatType.BattleUserInterfaceSkin = 33
MatType.BattleBackgroundSkin = 34
MatType.ImpressionSticker = 35
MatType.ImpressionPoster = 37
MatType.Strength = 60
MatType.Rune = 61
MatType.Item_Badge = 62
MatType.ACTIVITY_ENERGY = 66
MatType.Pet = 100
MatType.BorrowPet = 101
MatType.Formation = 102
MatType.Diamond = 104
MatType.Diamond_Consume = 105
MatType.Pack = 109
MatType.CommonBonus = 120
MatType.PayDiamond = 132
MatType.GodGem = 204
MatType.MOCK_EQUIPMENT = 2007
MatType.MOCK_STARGOD = 2008
MatType.MOCK_HOLY_STRIPE = 2012
MatType.Skill = 1000
MatType.Race = 1001
MatType.Job = 1002
MatType.Rare = 1003
MatType.Item_Fake = 1004
MatType.Rune_Suit = 1005
MatType.Item_Jump = 1006
MatType.PetSkin_Rare = 1007
MatType.Item_Jump_Right = 1008
MatType.Item_Normal = 1
MatType.Item_Talent = 6
MatType.Item_Fruit = 7
MatType.Item_Token = 8
MatType.Item_Piece = 12
MatType.Item_PetSoul = 13
MatType.Item_GoodFeel = 14
MatType.Item_ConsumeLottery = 16
MatType.Item_Flower = 17
MatType.Item_SubType = {
	[MatType.Item_Normal] = lang("道具"),
	[MatType.Item_Talent] = lang("天赋药"),
	[MatType.Item_Fruit] = lang("经验果"),
	[MatType.Item_Token] = lang("代币"),
	[MatType.Item_Piece] = lang("道具碎片")
}
MatType.Coin_Gold = 1
MatType.Coin_Heart = 2
MatType.Coin_Challenge = 3
MatType.Coin_SBean = 4
MatType.Coin_Family = 5
MatType.Coin_Dust = 8
MatType.Coin_VipExp = 15
MatType.Coin_Skin = 17
MatType.Coin_Mount = 26
MatType.Coin_Family_Luck = 26
MatType.Coin_Family_Money = 41
MatType.Diamond_Normal = 1
MatType.Diamond_Binding = 2
MatType.GodGem_Normal = 1
MatType.GodGem_Binding = 2
MatType.Rare_N = 1
MatType.Rare_R = 2
MatType.Rare_SR = 3
MatType.Rare_SSR = 4
MatType.RareName = {
	lang("rareName1"),
	lang("rareName2"),
	lang("rareName3"),
	(lang("rareName4"))
}

return MatType
