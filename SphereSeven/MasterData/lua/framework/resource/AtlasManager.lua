--[[
-- added by wsh @ 2017-01-08
-- 图集管理：为逻辑层透明化图集路径和图集资源加载等底层操作
-- 注意：
-- 1、只提供异步操作，为的是不需要逻辑层取操心图集AB是否已经加载的问题
-- 2、图集管理器不做资源缓存
-- 3、图片名称带后缀
--]]

local AtlasManager = BaseClass("AtlasManager", Singleton)
local sprite_type = typeof(CS.UnityEngine.Sprite)
local sprite_atlas_type = typeof(CS.UnityEngine.U2D.SpriteAtlas)

local SpriteAtlases = {
	"UI/Atlas/Battle/",
	"UI/Atlas/BodyHalf/",
	"UI/Atlas/BodyHalf_HX/",
	"UI/Atlas/Buff_CN/",
	"UI/Atlas/Buff_JA/",
	"UI/Atlas/Buff_HK/",
	"UI/Atlas/CardAvatar/",
	"UI/Atlas/Common/",
	"UI/Atlas/Currency/",
	"UI/Atlas/EnemyAvatar/",
	"UI/Atlas/Equip/",
	"UI/Atlas/EquipBg/",
	"UI/Atlas/FightSoul/",
	
	"UI/Atlas/Item/Crystal/",
	"UI/Atlas/Item/Gem/",
	"UI/Atlas/Item/Gift/",
	"UI/Atlas/Item/HolyWater/",
	"UI/Atlas/Item/JadePearl/",
	"UI/Atlas/Item/Other/",
	"UI/Atlas/ItemBg/",
	
	"UI/Atlas/LaunchAtkMap/",
	"UI/Atlas/Other/",
	"UI/Atlas/Prop/",
	"UI/Atlas/Rate/",
	"UI/Atlas/SkillIcon/",
	"UI/Atlas/Skin/",
	"UI/Atlas/SrAvatar/",
	"UI/Atlas/BattleArray/",
	"UI/Atlas/FormationEhance/",
	
	"UI/Atlas/JadePearl/",
	"UI/Atlas/Battle/",
	"UI/Atlas/MainProp/",
	"UI/Atlas/RareFrame/",
	"UI/Atlas/ListHalfBody/",
	"UI/Atlas/CardFrom/",
	"UI/Atlas/CardType/",
	"UI/Atlas/CardListFrame/",
	"UI/Atlas/CardLittle/",
	"UI/Atlas/CardLittleFrame/",
	"UI/Atlas/FightSoulSub/",
	"UI/Atlas/SummonRare/",
	"UI/Atlas/Dangrad/",

	"UI/Atlas/Section/StoryChapter/",
	"UI/Atlas/Section/StorySection1/",
	"UI/Atlas/Emoj/",
	"UI/Atlas/MusicIcon/",
	"UI/Atlas/ChapterIcon/",

	"UI/Atlas/BattleNumeric/",
	"UI/Atlas/BattleTip_JA/",
	"UI/Atlas/BattleTip_HK/",

	"UI/Atlas/Tag/",
	"UI/Atlas/LittleBuff/",
}

local function Texture2DToSprite(sprite)
	return CS.TransformExtension.Texture2DToSprite(sprite)
end

-- 从图集异步加载图片：回调方式
local function LoadImageAsync(self, atlas_config, image_name, callback, ...)
	local image_path=image_name
	if atlas_config~=nil then
	     local atlas_path = atlas_config.AtlasPath
	     image_path= atlas_path.."/"..image_name
	end
	local imageDir = string.match(image_path,"(.+/).+")
	local imageName = string.match(image_path,".+/(.+)")
	if table.contains(SpriteAtlases,imageDir) then --图集
		local spriteAtlasPath = imageDir.."SpriteAtlas.spriteatlas"
		--print("LoadImageAsync:从图集"..spriteAtlasPath.." 读取"..image_path)
		ResourcesManager:GetInstance():LoadAsync(spriteAtlasPath, sprite_atlas_type, function(spriteAtlas, ...)
			local sprite = spriteAtlas:GetSprite(string.split(imageName,".")[1])
			if callback then
				callback(not IsNull(sprite) and sprite or nil, ...)
			end
		end, ...)
	else --非图集
		ResourcesManager:GetInstance():LoadAsync(image_path, sprite_type, function(sprite, ...)
			if callback then
				callback(not IsNull(sprite) and Texture2DToSprite(sprite) or nil, ...)
			end
		end, ...)
	end
end
-- 从图集异步加载图片：协程方式
local function CoLoadImageAsync(self, image_path, progress_callback)
	local imageDir = string.match(image_path,"(.+/).+")
	local imageName = string.match(image_path,".+/(.+)")
	if table.contains(SpriteAtlases, imageDir) then --图集
		local spriteAtlasPath = imageDir.."SpriteAtlas.spriteatlas"
		local spriteAtlas = ResourcesManager:GetInstance():CoLoadAsync(spriteAtlasPath, sprite_atlas_type, progress_callback)
		if IsNull(spriteAtlas) then
			return nil
		end
		local sprite = spriteAtlas:GetSprite(string.split(imageName,".")[1])
		if IsNull(sprite) then
			Logger.LogError("CoLoadImageAsync: load file is null : " .. image_path)
			return nil
		else
			return sprite
		end
	else --非图集
		local sprite = ResourcesManager:GetInstance():CoLoadAsync(image_path, sprite_type, progress_callback)
		return not IsNull(sprite) and Texture2DToSprite(sprite) or nil
	end
end

AtlasManager.LoadImageAsync = LoadImageAsync
AtlasManager.CoLoadImageAsync = CoLoadImageAsync

return AtlasManager
