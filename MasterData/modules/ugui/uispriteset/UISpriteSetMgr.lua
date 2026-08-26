-- chunkname: @modules/ugui/uispriteset/UISpriteSetMgr.lua

module("modules.ugui.uispriteset.UISpriteSetMgr", package.seeall)

local UISpriteSetMgr = class("UISpriteSetMgr")

function UISpriteSetMgr:ctor()
	self._spriteSetList = {}
	self._dungeon = self:newSpriteSetUnit("ui/spriteassets/dungeon.asset")
	self._character = self:newSpriteSetUnit("ui/spriteassets/character.asset")
	self._characterget = self:newSpriteSetUnit("ui/spriteassets/characterget.asset")
	self._equip = self:newSpriteSetUnit("ui/spriteassets/equip.asset")
	self._common = self:newSpriteSetUnit("ui/spriteassets/common.asset")
	self._critter = self:newSpriteSetUnit("ui/spriteassets/critter.asset")
	self._fight = self:newSpriteSetUnit("ui/spriteassets/fight.asset")
	self._fightSkillCard = self:newSpriteSetUnit("ui/spriteassets/fight_skillcard.asset")
	self._fightSkillCard2 = self:newSpriteSetUnit("ui/spriteassets/fight_skillcard_2.asset")
	self._fightSkillCard3 = self:newSpriteSetUnit("ui/spriteassets/fight_skillcard_3.asset")
	self._fightpassive = self:newSpriteSetUnit("ui/spriteassets/fightpassive.asset")
	self._explore = self:newSpriteSetUnit("ui/spriteassets/explore.asset")
	self._weekwalk = self:newSpriteSetUnit("ui/spriteassets/weekwalk.asset")
	self._herogroup = self:newSpriteSetUnit("ui/spriteassets/herogroup.asset")
	self._summon = self:newSpriteSetUnit("ui/spriteassets/summon.asset")
	self._main = self:newSpriteSetUnit("ui/spriteassets/main.asset")
	self._meilanni = self:newSpriteSetUnit("ui/spriteassets/meilanni.asset")
	self._room = self:newSpriteSetUnit("ui/spriteassets/room.asset")
	self._share = self:newSpriteSetUnit("ui/spriteassets/share.asset")
	self._characterTalent = self:newSpriteSetUnit("ui/spriteassets/charactertalentup.asset")
	self._handbook = self:newSpriteSetUnit("ui/spriteassets/handbook.asset")
	self._puzzle = self:newSpriteSetUnit("ui/spriteassets/puzzle.asset")
	self._teachnote = self:newSpriteSetUnit("ui/spriteassets/teachnote.asset")
	self._store = self:newSpriteSetUnit("ui/spriteassets/store.asset")
	self._enemyinfo = self:newSpriteSetUnit("ui/spriteassets/enemyinfo.asset")
	self._herogroupequipicon = self:newSpriteSetUnit("ui/spriteassets/herogroupequipicon.asset")
	self._playerrarebg = self:newSpriteSetUnit("ui/spriteassets/playerrarebg.asset")
	self._currencyitem = self:newSpriteSetUnit("ui/spriteassets/currencyitem.asset")
	self._equipiconsmall = self:newSpriteSetUnit("ui/spriteassets/equipicon_small.asset")
	self._toast = self:newSpriteSetUnit("ui/spriteassets/toast.asset")
	self._buff = self:newSpriteSetUnit("ui/spriteassets/buff.asset")
	self._activitynovicetask = self:newSpriteSetUnit("ui/spriteassets/activitynovicetask.asset")
	self._signin = self:newSpriteSetUnit("ui/spriteassets/signin.asset")
	self._v1a3_bufficon = self:newSpriteSetUnit("ui/spriteassets/v1a3_bufficon.asset")
	self._v1a3_dungeon = self:newSpriteSetUnit("ui/spriteassets/v1a3_dungeon.asset")
	self._v1a3_astrology = self:newSpriteSetUnit("ui/spriteassets/v1a3_astrology_spriteset.asset")
	self._v1a3_store = self:newSpriteSetUnit("ui/spriteassets/v1a3_store_spriteset.asset")
	self._v1a3_enterview = self:newSpriteSetUnit("ui/spriteassets/v1a3_enterview.asset")
	self._v1a3_fairylandcard_spriteset = self:newSpriteSetUnit("ui/spriteassets/v1a3_fairylandcard_spriteset.asset")
	self._dungeonnavigation = self:newSpriteSetUnit("ui/spriteassets/dungeon_navigation.asset")
	self._dungeonlevelrule = self:newSpriteSetUnit("ui/spriteassets/dungeon_levelrule.asset")
	self._seasonitem = self:newSpriteSetUnit("ui/spriteassets/season.asset")
	self._activitywarmup = self:newSpriteSetUnit("ui/spriteassets/activitywarmup.asset")
	self._versionactivity = self:newSpriteSetUnit("ui/spriteassets/versionactivity.asset")
	self._activitychessmap = self:newSpriteSetUnit("ui/spriteassets/activitychessmap.asset")
	self._versionactivitypushbox = self:newSpriteSetUnit("ui/spriteassets/versionactivitypushbox.asset")
	self._versionactivity114 = self:newSpriteSetUnit("ui/spriteassets/versionactivity114_1_2.asset")
	self._versionactivitywhitehouse = self:newSpriteSetUnit("ui/spriteassets/versionactivitywhitehouse_1_2.asset")
	self._versionactivity1_2 = self:newSpriteSetUnit("ui/spriteassets/versionactivity_1_2.asset")
	self._versionactivity1_2_yaxian = self:newSpriteSetUnit("ui/spriteassets/versionactivity_1_2_yaxian.asset")
	self._versionactivitytrade_1_2 = self:newSpriteSetUnit("ui/spriteassets/versionactivitytrade_1_2.asset")
	self._versionactivitydungeon_1_2 = self:newSpriteSetUnit("ui/spriteassets/versionactivitydungeon_1_2.asset")
	self._versionactivity1_3_jialabona = self:newSpriteSetUnit("ui/spriteassets/v1a3_role1_spriteset.asset")
	self._versionactivity1_3_chess = self:newSpriteSetUnit("ui/spriteassets/v1a3_role1_spriteset.asset")
	self._versionactivity1_3_armpipe = self:newSpriteSetUnit("ui/spriteassets/v1a3_arm_spriteset.asset")
	self._v1a4_shiprepair = self:newSpriteSetUnit("ui/spriteassets/v1a4_shiprepair.asset")
	self._v1a4_collect = self:newSpriteSetUnit("ui/spriteassets/v1a4_collect_spriteset.asset")
	self._v1a4_role37 = self:newSpriteSetUnit("ui/spriteassets/v1a4_role37_spriteset.asset")
	self._mail = self:newSpriteSetUnit("ui/spriteassets/mail.asset")
	self._v1a4_bossrush = self:newSpriteSetUnit("ui/spriteassets/v1a4_bossrush_spriteset.asset")
	self._v1a4_seasonsum = self:newSpriteSetUnit("ui/spriteassets/v1a4_season_sum_spriteset.asset")
	self._v1a4_enterview = self:newSpriteSetUnit("ui/spriteassets/v1a4_enterview.asset")
	self._v1a5_enterview = self:newSpriteSetUnit("ui/spriteassets/v1a5_enterview.asset")
	self._v1a5_revivaltask = self:newSpriteSetUnit("ui/spriteassets/v1a5_dungeon_explore_spriteset.asset")
	self._v1a5_chess = self:newSpriteSetUnit("ui/spriteassets/v1a5_kerandian_spriteset.asset")
	self._v1a5_aizila = self:newSpriteSetUnit("ui/spriteassets/v1a5_aizila_spriteset.asset")
	self._v1a5_dungeon_store = self:newSpriteSetUnit("ui/spriteassets/v1a5_store_spriteset.asset")
	self._v1a5_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v1a5_dungeon.asset")
	self._v1a5_dungeon_build = self:newSpriteSetUnit("ui/spriteassets/v1a5_building_spriteset.asset")
	self._v1a5_news = self:newSpriteSetUnit("ui/spriteassets/v1a5_news.asset")
	self._v1a5_peaceulu = self:newSpriteSetUnit("ui/spriteassets/v1a5_peaceulu_spriteset.asset")
	self._dialogueChess = self:newSpriteSetUnit("ui/spriteassets/dialogue.asset")
	self._v1a5_df_sign = self:newSpriteSetUnit("ui/spriteassets/v1a5_df_sign_spriteset.asset")
	self._v1a5_warmup = self:newSpriteSetUnit("ui/spriteassets/v1a5_warmup_spriteset.asset")
	self._v1a6_cachot = self:newSpriteSetUnit("ui/spriteassets/v1a6_cachot.asset")
	self._v1a6_enterview = self:newSpriteSetUnit("ui/spriteassets/v1a6_enterview.asset")
	self._v1a6_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v1a6_dungeon.asset")
	self._v1a6_dungeon_store = self:newSpriteSetUnit("ui/spriteassets/v1a6_store_spriteset.asset")
	self._v1a6_dungeon_skill = self:newSpriteSetUnit("ui/spriteassets/v1a6_talent_spriteset.asset")
	self._v1a6_seasonsum = self:newSpriteSetUnit("ui/spriteassets/v1a6_season_sum_spriteset.asset")
	self._v1a7_main_activity = self:newSpriteSetUnit("ui/spriteassets/v1a7_mainactivity_spriteset.asset")
	self._v1a7_lantern = self:newSpriteSetUnit("ui/spriteassets/v1a7_lamp_spriteset.asset")
	self._season123 = self:newSpriteSetUnit("ui/spriteassets/season123.asset")
	self._v1a7_v1a2reprint = self:newSpriteSetUnit("ui/spriteassets/v1a7_v1a2reprint_spriteset.asset")
	self._v1a8_main_activity = self:newSpriteSetUnit("ui/spriteassets/v1a8_mainactivity_spriteset.asset")
	self._v1a8_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v1a8_dungeon.asset")
	self._v1a8_factory_sprite = self:newSpriteSetUnit("ui/spriteassets/v1a8_factory.asset")
	self._v1a8_warmup_sprite = self:newSpriteSetUnit("ui/spriteassets/v1a8_warmup.asset")
	self._v1a9_main_activity = self:newSpriteSetUnit("ui/spriteassets/v1a9_mainactivity_spriteset.asset")
	self._toughbattle_role = self:newSpriteSetUnit("ui/spriteassets/toughbattle_role_spriteset.asset")
	self._toughbattle = self:newSpriteSetUnit("ui/spriteassets/toughbattle_spriteset.asset")
	self._dragonboat = self:newSpriteSetUnit("ui/spriteassets/v1a9_dragonboat_spriteset.asset")
	self._rouge = self:newSpriteSetUnit("ui/spriteassets/rouge.asset")
	self._rouge2 = self:newSpriteSetUnit("ui/spriteassets/rouge2.asset")
	self._rouge3 = self:newSpriteSetUnit("ui/spriteassets/rouge3.asset")
	self._rouge4 = self:newSpriteSetUnit("ui/spriteassets/rouge4.asset")
	self._rouge5 = self:newSpriteSetUnit("ui/spriteassets/rouge5.asset")
	self._rouge6 = self:newSpriteSetUnit("ui/spriteassets/rouge6.asset")
	self._rouge7 = self:newSpriteSetUnit("ui/spriteassets/rouge7.asset")
	self._rouge8 = self:newSpriteSetUnit("ui/spriteassets/rouge8.asset")
	self._fairyland = self:newSpriteSetUnit("ui/spriteassets/fairyland_spriteset.asset")
	self._bgmswitch = self:newSpriteSetUnit("ui/spriteassets/bgmtoggle.asset")
	self._commandstation = self:newSpriteSetUnit("ui/spriteassets/sp_commandstation.asset")
	self._v2a0_main_activity = self:newSpriteSetUnit("ui/spriteassets/v2a0_mainactivity_spriteset.asset")
	self._v2a0_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a0_dungeon.asset")
	self._v2a0_paint_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a0_paint_spriteset.asset")
	self._playerinfo = self:newSpriteSetUnit("ui/spriteassets/playerinfo.asset")
	self._optionalgift = self:newSpriteSetUnit("ui/spriteassets/optionalgift_spriteset.asset")
	self._v2a1_aergusi = self:newSpriteSetUnit("ui/spriteassets/v2a1_aergusi.asset")
	self._v2a1_act165 = self:newSpriteSetUnit("ui/spriteassets/v2a1_act165.asset")
	self._v2a1_act165_2 = self:newSpriteSetUnit("ui/spriteassets/v2a1_act165_2.asset")
	self._v2a1_main_activity = self:newSpriteSetUnit("ui/spriteassets/v2a1_mainactivity_spriteset.asset")
	self._v2a1_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a1_dungeon.asset")
	self._v2a1_warmup = self:newSpriteSetUnit("ui/spriteassets/v2a1_warmup.asset")
	self._antique = self:newSpriteSetUnit("ui/spriteassets/antique.asset")
	self._v2a2_eliminate = self:newSpriteSetUnit("ui/spriteassets/v2a2_eliminate.asset")
	self._v2a2_main_activity = self:newSpriteSetUnit("ui/spriteassets/v2a2_mainactivity_spriteset.asset")
	self._v2a2_eliminate_point = self:newSpriteSetUnit("ui/spriteassets/v2a2_eliminate_pointpic.asset")
	self._season166 = self:newSpriteSetUnit("ui/spriteassets/season166.asset")
	self._season166_info = self:newSpriteSetUnit("ui/spriteassets/season166_info.asset")
	self._v2a2_lopera = self:newSpriteSetUnit("ui/spriteassets/v2a2_lopera_spriteset.asset")
	self._v2a3_main_activity = self:newSpriteSetUnit("ui/spriteassets/v2a3_mainactivity_spriteset.asset")
	self._v2a3_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a3_dungeon.asset")
	self._v2a3_zhixinquaner = self:newSpriteSetUnit("ui/spriteassets/v2a3_zhixinquaner_spriteset.asset")
	self._v2a4_main_activity = self:newSpriteSetUnit("ui/spriteassets/v2a4_mainactivity_spriteset.asset")
	self._v2a4_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a4_dungeon.asset")
	self._v2a4_bakaluoer_spriteset = self:newSpriteSetUnit("ui/spriteassets/v2a4_bakaluoer_spriteset.asset")
	self._tower = self:newSpriteSetUnit("ui/spriteassets/tower.asset")
	self._tower_permanent = self:newSpriteSetUnit("ui/spriteassets/tower_permanent.asset")
	self._tower2 = self:newSpriteSetUnit("ui/spriteassets/tower2.asset")
	self._act174 = self:newSpriteSetUnit("ui/spriteassets/act174.asset")
	self._act178 = self:newSpriteSetUnit("ui/spriteassets/v2a4_tutushizi_spriteset.asset")
	self._v2a4_wuerlixi_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a4_wuerlixi_spriteset.asset")
	self._playercard = self:newSpriteSetUnit("ui/spriteassets/playercard.asset")
	self._playercard2 = self:newSpriteSetUnit("ui/spriteassets/playercard2.asset")
	self._v2a5_main_activity = self:newSpriteSetUnit("ui/spriteassets/v2a5_mainactivity_spriteset.asset")
	self._v2a5_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a5_dungeon.asset")
	self._v2a5_autochess_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a5_autochess_spriteset.asset")
	self._v2a5_challenge_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a5_challenge_spriteset.asset")
	self._v2a5_liangyue_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a5_liangyue_spriteset.asset")
	self._socialskin = self:newSpriteSetUnit("ui/spriteassets/social_1.asset")
	self._v2a6dicehero = self:newSpriteSetUnit("ui/spriteassets/v2a6_dicehero_spriteset.asset")
	self._v2a6_xugouji = self:newSpriteSetUnit("ui/spriteassets/v2a6_xugouji_spriteset.asset")
	self._v2a6_main_activity = self:newSpriteSetUnit("ui/spriteassets/v2a6_mainactivity_spriteset.asset")
	self._v2a8_main_activity = self:newSpriteSetUnit("ui/spriteassets/v2a8_mainactivity_spriteset.asset")
	self._v3a0_main_activity = self:newSpriteSetUnit("ui/spriteassets/v3a0_mainactivity_spriteset.asset")
	self._v3a2_main_activity = self:newSpriteSetUnit("ui/spriteassets/v3a2_mainactivity_spriteset.asset")
	self._v3a3_main_activity = self:newSpriteSetUnit("ui/spriteassets/v3a3_mainactivity_spriteset.asset")
	self._v3a4_main_activity = self:newSpriteSetUnit("ui/spriteassets/v3a4_mainactivity_spriteset.asset")
	self._v2a7_main_activity = self:newSpriteSetUnit("ui/spriteassets/v2a7_mainactivity_spriteset.asset")
	self._v2a7_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a7_dungeon.asset")
	self._v2a7_coopergarland_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a7_coopergarland_spriteset.asset")
	self._v2a7_hissabeth_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a7_hissabeth_spriteset.asset")
	self._v2a9_main_activity = self:newSpriteSetUnit("ui/spriteassets/v2a9_mainactivity_spriteset.asset")
	self._v2a9_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a9_dungeon.asset")
	self._sp01_odysseydungeon = self:newSpriteSetUnit("ui/spriteassets/sp01_odysseydungeon.asset")
	self._sp01_odysseydungeonelement = self:newSpriteSetUnit("ui/spriteassets/sp01_odysseydungeonelement.asset")
	self._sp01_odysseytalent = self:newSpriteSetUnit("ui/spriteassets/sp01_odyssey_talenticon.asset")
	self._sp01_assassin = self:newSpriteSetUnit("ui/spriteassets/assassin2.asset")
	self._sp01_talenticon = self:newSpriteSetUnit("ui/spriteassets/sp01_odyssey_talenticon.asset")
	self._sp01_act205 = self:newSpriteSetUnit("ui/spriteassets/v2a9_act205_spriteset.asset")
	self._survival = self:newSpriteSetUnit("ui/spriteassets/survival_spriteset.asset")
	self._survival2 = self:newSpriteSetUnit("ui/spriteassets/survival_spriteset_2.asset")
	self._v2a8_molideer_sprite = self:newSpriteSetUnit("ui/spriteassets/v2a8_molideer.asset")
	self._skinhandbook_sprite = self:newSpriteSetUnit("ui/spriteassets/skinhandbook_spriteset.asset")
	self._v3a0_malianna = self:newSpriteSetUnit("ui/spriteassets/v3a0_malianna.asset")
	self._v3a0_karong = self:newSpriteSetUnit("ui/spriteassets/v3a0_karong.asset")
	self._v3a1_main_activity = self:newSpriteSetUnit("ui/spriteassets/v3a1_mainactivity_spriteset.asset")
	self._v3a1_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v3a1_dungeon.asset")
	self._v3a2_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v3a2_dungeon.asset")
	self._v3a3_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v3a3_dungeon.asset")
	self._v3a4_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v3a4_dungeon.asset")
	self._rolestory_sprite = self:newSpriteSetUnit("ui/spriteassets/rolestory.asset")
	self._fight_tower_sprite = self:newSpriteSetUnit("ui/spriteassets/fight_tower.asset")
	self._v3a1_gaosiniao_spriteset = self:newSpriteSetUnit("ui/spriteassets/v3a1_gaosiniao_spriteset.asset")
	self._nationalgift = self:newSpriteSetUnit("ui/spriteassets/optionalgift_spriteset.asset")
	self._rouge2_sprite = self:newSpriteSetUnit("ui/spriteassets/rouge2.asset")
	self._udimo_sprite = self:newSpriteSetUnit("ui/spriteassets/udimo_spriteset.asset")
	self._v3a2_cruise_spriteset = self:newSpriteSetUnit("ui/spriteassets/v3a2_cruise_spriteset.asset")
	self._v3a2_activitycollect = self:newSpriteSetUnit("ui/spriteassets/v3a2_activitycollect.asset")
	self._findlovegame = self:newSpriteSetUnit("modules/party_game/ui/spriteassets/v3a4_laplace_spriteset.asset")
	self._partygamecard = self:newSpriteSetUnit("ui/spriteassets/partygame_card.asset")
	self._v3a3_eliminate_spriteset = self:newSpriteSetUnit("ui/spriteassets/v3a3_eliminate_spriteset.asset")
	self._v3a3_igor_spriteset = self:newSpriteSetUnit("ui/spriteassets/v3a3_igor_spriteset.asset")
	self._v3a3_marsha_spriteset = self:newSpriteSetUnit("ui/spriteassets/v3a3_marsha_spriteset.asset")
	self._v3a4_laplace_spriteset = self:newSpriteSetUnit("modules/party_game/ui/spriteassets/v3a4_laplace_spriteset.asset")
	self._v3a4_chg_spriteset = self:newSpriteSetUnit("ui/spriteassets/v3a4_chg_spriteset.asset")
	self._v3a5_main_activity = self:newSpriteSetUnit("ui/spriteassets/v3a5_mainactivity_spriteset.asset")
	self._v3a5_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v3a2_dungeon.asset")
	self._v3a5_lamona = self:newSpriteSetUnit("ui/spriteassets/v3a5_lamona_spriteset.asset")
	self._v3a5_schoolstart = self:newSpriteSetUnit("ui/spriteassets/v3a5_schoolstart_spriteset.asset")
	self._v3a6_main_activity = self:newSpriteSetUnit("ui/spriteassets/v3a6_mainactivity_spriteset.asset")
	self._v3a6_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v3a2_dungeon.asset")
	self._v3a6_dormitorymode_sprite = self:newSpriteSetUnit("ui/spriteassets/v3a6_dormitorymode_spriteset.asset")
	self._v3a7_main_activity = self:newSpriteSetUnit("ui/spriteassets/v3a7_mainactivity_spriteset.asset")
	self._avg_spelling_sprite = self:newSpriteSetUnit("ui/spriteassets/avg_spelling_spriteset.asset")
	self._sodache = self:newSpriteSetUnit("modules/sodache/ui/spriteassets/sodache.asset")
	self._sodache2 = self:newSpriteSetUnit("modules/sodache/ui/spriteassets/sodache_2.asset")
	self._sodache3 = self:newSpriteSetUnit("modules/sodache/ui/spriteassets/sodache_3.asset")
	self._v3a7_activity3nd_sprite = self:newSpriteSetUnit("ui/spriteassets/v3a7_activity3nd_spriteset.asset")
	self._v3a7_teaching_system = self:newSpriteSetUnit("ui/spriteassets/v3a7_teaching_spriteset.asset")
	self.v3a7_xiaoruiannong_spriteset = self:newSpriteSetUnit("ui/spriteassets/v3a7_xiaoruiannong_spriteset.asset")
	self._v3a7_wmz_spriteset = self:newSpriteSetUnit("ui/spriteassets/v3a7_wmz_spriteset.asset")
	self._v3a8_dianjishi_spriteset = self:newSpriteSetUnit("ui/spriteassets/v3a8_dianjishi_spriteset.asset")
	self._v3a8_main_activity = self:newSpriteSetUnit("ui/spriteassets/v3a8_mainactivity_spriteset.asset")
	self._v3a8_dungeon_sprite = self:newSpriteSetUnit("ui/spriteassets/v3a2_dungeon.asset")
	self._v3a9_main_activity = self:newSpriteSetUnit("ui/spriteassets/v3a9_mainactivity_spriteset.asset")
	self._v3a9_hedone_sprite = self:newSpriteSetUnit("ui/spriteassets/v3a9_hedone_spriteset.asset")
	self._v3a9_racing_sprit = self:newSpriteSetUnit("ui/spriteassets/v3a9_racing_spriteset.asset")
	self._sp02_atomicdungeonelement = self:newSpriteSetUnit("ui/spriteassets/sp02_atomicdungeonelement.asset")
	self._sp02_atomicIcon = self:newSpriteSetUnit("ui/spriteassets/sp02_atomicforyou.asset")
	self._sp02_atomicActivityIcon = self:newSpriteSetUnit("ui/spriteassets/sp02_atomic_activity.asset")
	self._sp02_paomian = self:newSpriteSetUnit("ui/spriteassets/sp02_paomian.asset")
	self._abyss = self:newSpriteSetUnit("ui/spriteassets/v3a9_cloudredemption_spriteset.asset")
	self._v3a9_naxisuosi = self:newSpriteSetUnit("ui/spriteassets/v3a9_naxisuosi_spriteset.asset")
end

function UISpriteSetMgr:newSpriteSetUnit(path)
	local unit = UISpriteSetUnit.New()

	unit:init(path)
	table.insert(self._spriteSetList, unit)

	return unit
end

function UISpriteSetMgr:setUiFBSprite(image, name, setNativeSize)
	self._dungeon:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:getDungeonSprite()
	return self._dungeon
end

function UISpriteSetMgr:setUiCharacterSprite(image, name, setNativeSize)
	self._character:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setCharactergetSprite(image, name, setNativeSize)
	self._characterget:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setEquipSprite(image, name, setNativeSize)
	self._equip:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setCommonSprite(image, name, setNativeSize, alpha)
	self._common:setSprite(image, name, setNativeSize, alpha)
end

function UISpriteSetMgr:getCommonSprite(name)
	return self._common:getSprite(name)
end

function UISpriteSetMgr:setCritterSprite(image, name, setNativeSize, alpha)
	self._critter:setSprite(image, name, setNativeSize, alpha)
end

function UISpriteSetMgr:setFightSprite(image, name, setNativeSize)
	self._fight:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setFightSkillCardSprite(image, name, setNativeSize)
	local cardSkin = FightCardDataHelper.getCardSkin()
	local spriteMgr = self._fightSkillCard

	spriteMgr = cardSkin == 672802 and self._fightSkillCard2 or (cardSkin ~= 672803 or true) and spriteMgr

	self._fightSkillCard3:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setFightPassiveSprite(image, name, setNativeSize)
	self._fightpassive:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setWeekWalkSprite(image, name, setNativeSize, alpha)
	self._weekwalk:setSprite(image, name, setNativeSize, alpha)
end

function UISpriteSetMgr:getWeekWalkSpriteSetUnit()
	return self._weekwalk and self._weekwalk:getSpriteSetAsset()
end

function UISpriteSetMgr:setHeroGroupSprite(image, name, setNativeSize)
	self._herogroup:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSummonSprite(image, name, setNativeSize)
	self._summon:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setExploreSprite(image, name, setNativeSize)
	self._explore:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setMainSprite(image, name, setNativeSize)
	self._main:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setMailSprite(image, name, setNativeSize)
	self._mail:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setMeilanniSprite(image, name, setNativeSize)
	self._meilanni:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setRoomSprite(image, name, setNativeSize)
	self._room:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setShareSprite(image, name, setNativeSize)
	self._share:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setCharacterTalentSprite(image, name, setNativeSize)
	self._characterTalent:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setHandBookCareerSprite(image, name, setNativeSize)
	self._handbook:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setPuzzleSprite(image, name, setNativeSize)
	self._puzzle:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setTeachNoteSprite(image, name, setNativeSize)
	self._teachnote:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setStoreGoodsSprite(image, name, setNativeSize)
	self._store:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setEnemyInfoSprite(image, name, setNativeSize)
	self._enemyinfo:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setHerogroupEquipIconSprite(image, name, setNativeSize)
	self._herogroupequipicon:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setPlayerRareBgSprite(image, name, setNativeSize)
	self._playerrarebg:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setCurrencyItemSprite(image, name, setNativeSize)
	self._currencyitem:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setToastSprite(image, name, setNativeSize)
	self._toast:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setBuffSprite(image, name, setNativeSize)
	self._buff:setSprite(image, tostring(name), setNativeSize)
end

function UISpriteSetMgr:setActivityNoviceTaskSprite(image, name, setNativeSize)
	self._activitynovicetask:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSignInSprite(image, name, setNativeSize)
	self._signin:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a3BuffIconSprite(image, name, setNativeSize)
	self._v1a3_bufficon:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a3AstrologySprite(image, name, setNativeSize, alpha)
	self._v1a3_astrology:setSprite(image, name, setNativeSize, alpha)
end

function UISpriteSetMgr:setV1a3StoreSprite(image, name, setNativeSize, alpha)
	self._v1a3_store:setSprite(image, name, setNativeSize, alpha)
end

function UISpriteSetMgr:setV1a3EnterViewSprite(image, name, setNativeSize, alpha)
	self._v1a3_enterview:setSprite(image, name, setNativeSize, alpha)
end

function UISpriteSetMgr:setV1a4EnterViewSprite(image, name, setNativeSize, alpha)
	self._v1a4_enterview:setSprite(image, name, setNativeSize, alpha)
end

function UISpriteSetMgr:setV1a5EnterViewSprite(image, name, setNativeSize, alpha)
	self._v1a5_enterview:setSprite(image, name, setNativeSize, alpha)
end

function UISpriteSetMgr:setV1a3FairyLandCardSprite(image, name, setNativeSize, alpha)
	self._v1a3_fairylandcard_spriteset:setSprite(image, name, setNativeSize, alpha)
end

function UISpriteSetMgr:setDungeonNavigationSprite(image, name, setNativeSize)
	self._dungeonnavigation:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setDungeonLevelRuleSprite(image, name, setNativeSize)
	self._dungeonlevelrule:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSeasonSprite(image, name, setNativeSize)
	self._seasonitem:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setActivityWarmUpSprite(image, name, setNativeSize)
	self._activitywarmup:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setVersionActivitySprite(image, name, setNativeSize)
	self._versionactivity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setVersionActivity1_3Sprite(image, name, setNativeSize)
	self._v1a3_dungeon:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setActivityChessMapSprite(image, name, setNativeSize)
	self._activitychessmap:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setPushBoxSprite(image, name, setNativeSize)
	self._versionactivitypushbox:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setVersionActivity114Sprite(image, name, setNativeSize)
	self._versionactivity114:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setVersionActivitywhitehouseSprite(image, name, setNativeSize)
	self._versionactivitywhitehouse:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setVersionActivity1_2Sprite(image, name, setNativeSize)
	self._versionactivity1_2:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setYaXianSprite(image, name, setNativeSize)
	self._versionactivity1_2_yaxian:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setVersionActivityTrade_1_2Sprite(image, name, setNativeSize)
	self._versionactivitytrade_1_2:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setVersionActivityDungeon_1_2Sprite(image, name, setNativeSize)
	self._versionactivitydungeon_1_2:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setJiaLaBoNaSprite(image, name, setNativeSize)
	self._versionactivity1_3_jialabona:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setActivity1_3ChessSprite(image, name, setNativeSize)
	self._versionactivity1_3_chess:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setArmPipeSprite(image, name, setNativeSize)
	self._versionactivity1_3_armpipe:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a4ShiprepairSprite(image, name, setNativeSize)
	self._v1a4_shiprepair:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a4CollectSprite(image, name, setNativeSize)
	self._v1a4_collect:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a4Role37Sprite(image, name, setNativeSize)
	self._v1a4_role37:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a4BossRushSprite(image, name, setNativeSize)
	self._v1a4_bossrush:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a4SeasonSumSprite(image, name, setNativeSize)
	self._v1a4_seasonsum:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a5RevivalTaskSprite(image, name, setNativeSize)
	self._v1a5_revivaltask:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a5ChessSprite(image, name, setNativeSize)
	self._v1a5_chess:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a5AiZiLaSprite(image, name, setNativeSize)
	self._v1a5_aizila:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a5DungeonStoreSprite(image, name, setNativeSize)
	self._v1a5_dungeon_store:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a5DungeonSprite(image, name, setNativeSize)
	self._v1a5_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a5DungeonBuildSprite(image, name, setNativeSize)
	self._v1a5_dungeon_build:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setNewsSprite(image, name, setNativeSize)
	self._v1a5_news:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setPeaceUluSprite(image, name, setNativeSize)
	self._v1a5_peaceulu:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setDialogueChessSprite(image, name, setNativeSize)
	self._dialogueChess:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a5DfSignSprite(image, name, setNativeSize)
	self._v1a5_df_sign:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a5WarmUpSprite(image, name, setNativeSize)
	self._v1a5_warmup:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a6CachotSprite(image, name, setNativeSize)
	self._v1a6_cachot:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a6DungeonSprite(image, name, setNativeSize)
	self._v1a6_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a6DungeonStoreSprite(image, name, setNativeSize)
	self._v1a6_dungeon_store:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a6DungeonSkillSprite(image, name, setNativeSize)
	self._v1a6_dungeon_skill:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a6EnterSprite(image, name, setNativeSize)
	self._v1a6_enterview:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a7MainActivitySprite(image, name, setNativeSize)
	self._v1a7_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a7LanternSprite(image, name, setNativeSize)
	self._v1a7_lantern:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSeason123Sprite(image, name, setNativeSize)
	self._season123:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a7ReprintSprite(image, name, setNativeSize)
	self._v1a7_v1a2reprint:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a6SeasonSumSprite(image, name, setNativeSize)
	self._v1a6_seasonsum:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a8MainActivitySprite(image, name, setNativeSize)
	self._v1a8_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a8DungeonSprite(image, name, setNativeSize)
	self._v1a8_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a8FactorySprite(image, name, setNativeSize)
	self._v1a8_factory_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a8WarmUpSprite(image, name, setNativeSize)
	self._v1a8_warmup_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV1a9MainActivitySprite(image, name, setNativeSize)
	self._v1a9_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setToughBattleRoleSprite(image, name, setNativeSize)
	self._toughbattle_role:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setToughBattleSprite(image, name, setNativeSize)
	self._toughbattle:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setDragonBoatSprite(image, name, setNativeSize)
	self._dragonboat:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setRougeSprite(image, name, setNativeSize)
	self._rouge:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setRouge2Sprite(image, name, setNativeSize)
	self._rouge2:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setRouge3Sprite(image, name, setNativeSize)
	self._rouge3:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setRouge4Sprite(image, name, setNativeSize)
	self._rouge4:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setRouge5Sprite(image, name, setNativeSize)
	self._rouge5:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setRouge6Sprite(image, name, setNativeSize)
	self._rouge6:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setRouge7Sprite(image, name, setNativeSize)
	self._rouge7:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setRouge8Sprite(image, name, setNativeSize)
	self._rouge8:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setFairyLandSprite(image, name, setNativeSize)
	self._fairyland:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setBgmSwitchToggleSprite(image, name, setNativeSize)
	self._bgmswitch:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setCommandStationSprite(image, name, setNativeSize)
	self._commandstation:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a0MainActivitySprite(image, name, setNativeSize)
	self._v2a0_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a0DungeonSprite(image, name, setNativeSize)
	self._v2a0_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a0PaintSprite(image, name, setNativeSize)
	self._v2a0_paint_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setPlayerInfoSprite(image, name, setNativeSize)
	self._playerinfo:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setOptionalGiftSprite(image, name, setNativeSize)
	self._optionalgift:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a2MainActivitySprite(image, name, setNativeSize)
	self._v2a2_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a1AergusiSprite(image, name, setNativeSize)
	self._v2a1_aergusi:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a1Act165Sprite(image, name, setNativeSize)
	self._v2a1_act165:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a1Act165_2Sprite(image, name, setNativeSize)
	self._v2a1_act165_2:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a1MainActivitySprite(image, name, setNativeSize)
	self._v2a1_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a1DungeonSprite(image, name, setNativeSize)
	self._v2a1_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a2EliminateSprite(image, name, setNativeSize)
	self._v2a2_eliminate:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a1WarmupSprite(image, name, setNativeSize)
	self._v2a1_warmup:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setAntiqueSprite(image, name, setNativeSize)
	self._antique:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a2eliminatePointSprite(image, name, setNativeSize)
	self._v2a2_eliminate_point:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSeason166Sprite(image, name, setNativeSize)
	self._season166:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSeason166InfoSprite(image, name, setNativeSize)
	self._season166_info:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setLoperaItemSprite(image, name, setNativeSize)
	self._v2a2_lopera:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a3MainActivitySprite(image, name, setNativeSize)
	self._v2a3_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a3DungeonSprite(image, name, setNativeSize)
	self._v2a3_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setMusicSprite(image, name, setNativeSize)
	self._v2a4_bakaluoer_spriteset:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setTowerSprite(image, name, setNativeSize)
	self._tower:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setTowerPermanentSprite(image, name, setNativeSize)
	self._tower_permanent:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setTower2Sprite(image, name, setNativeSize)
	self._tower2:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setAct174Sprite(image, name, setNativeSize)
	self._act174:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setAct178Sprite(image, name, setNativeSize, alpha)
	self._act178:setSprite(image, name, setNativeSize, alpha)
end

function UISpriteSetMgr:setV2a3ZhiXinQuanErSprite(image, name, setNativeSize)
	self._v2a3_zhixinquaner:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a4DungeonSprite(image, name, setNativeSize)
	self._v2a4_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a4MainActivitySprite(image, name, setNativeSize)
	self._v2a4_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a4WuErLiXiSprite(image, name, setNativeSize)
	self._v2a4_wuerlixi_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setPlayerCardSprite(image, name, setNativeSize)
	self._playercard:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setPlayerCard2Sprite(image, name, setNativeSize)
	self._playercard2:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a5MainActivitySprite(image, name, setNativeSize)
	self._v2a5_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a5DungeonSprite(image, name, setNativeSize)
	self._v2a5_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setAutoChessSprite(image, name, setNativeSize)
	self._v2a5_autochess_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setChallengeSprite(image, name, setNativeSize)
	self._v2a5_challenge_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a5LiangYueSprite(image, name, setNativeSize)
	self._v2a5_liangyue_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a6MainActivitySprite(image, name, setNativeSize)
	self._v2a6_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a8MainActivitySprite(image, name, setNativeSize)
	self._v2a8_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a0MainActivitySprite(image, name, setNativeSize)
	self._v3a0_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a2MainActivitySprite(image, name, setNativeSize)
	self._v3a2_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a3MainActivitySprite(image, name, setNativeSize)
	self._v3a3_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a7MainActivitySprite(image, name, setNativeSize)
	self._v2a7_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a7DungeonSprite(image, name, setNativeSize)
	self._v2a7_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a7CooperGarlandSprite(image, name, setNativeSize)
	self._v2a7_coopergarland_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSocialSkinSprite(image, name, setNativeSize)
	self._socialskin:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setDiceHeroSprite(image, name, setNativeSize)
	self._v2a6dicehero:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setXugoujiSprite(image, name, setNativeSize)
	self._v2a6_xugouji:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setHisSaBethSprite(image, name, setNativeSize)
	self._v2a7_hissabeth_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a9MainActivitySprite(image, name, setNativeSize)
	self._v2a9_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV2a9DungeonSprite(image, name, setNativeSize)
	self._v2a9_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSp01OdysseyDungeonSprite(image, name, setNativeSize)
	self._sp01_odysseydungeon:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSp01OdysseyDungeonElementSprite(image, name, setNativeSize)
	self._sp01_odysseydungeonelement:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSp01OdysseyTalentSprite(image, name, setNativeSize)
	self._sp01_odysseytalent:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSp01AssassinSprite(image, name, setNativeSize)
	self._sp01_assassin:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSp01TalentIconSprite(image, name, setNativeSize)
	self._sp01_talenticon:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSp01Act205Sprite(image, name, setNativeSize)
	self._sp01_act205:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSurvivalSprite(image, name, setNativeSize)
	self._survival:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSurvivalSprite2(image, name, setNativeSize, alpha)
	self._survival2:setSprite(image, name, setNativeSize, alpha)
end

function UISpriteSetMgr:setMoLiDeErSprite(image, name, setNativeSize)
	self._v2a8_molideer_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSkinHandbook(image, name, setNativeSize)
	self._skinhandbook_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setMaliAnNaSprite(image, name, setNativeSize)
	self._v3a0_malianna:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a0KaRongSprite(image, name, setNativeSize)
	self._v3a0_karong:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a1MainActivitySprite(image, name, setNativeSize)
	self._v3a1_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a1DungeonSprite(image, name, setNativeSize)
	self._v3a1_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a2DungeonSprite(image, name, setNativeSize)
	self._v3a2_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a3DungeonSprite(image, name, setNativeSize)
	self._v3a3_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setRoleStorySprite(image, name, setNativeSize)
	self._rolestory_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setFightTowerSprite(image, name, setNativeSize)
	self._fight_tower_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a1GaoSiNiaoSprite(image, name, setNativeSize)
	self._v3a1_gaosiniao_spriteset:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setNationalGiftSprite(image, name, setNativeSize)
	self._nationalgift:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setRouge_V2_Sprite(image, name, setNativeSize)
	self._rouge2_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setUdimoSprite(image, name, setNativeSize)
	self._udimo_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a2CruiseSprite(image, name, setNativeSize)
	self._v3a2_cruise_spriteset:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a2Turnnback3Sprite(image, name, setNativeSize)
	self._v3a2_activitycollect:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setPartyGameSprite(image, name, setNativeSize)
	return
end

function UISpriteSetMgr:setFindLoveGameSprite(image, name, setNativeSize)
	self._findlovegame:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setPartyGameCardSprite(image, name, setNativeSize)
	self._partygamecard:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a3EliminateSprite(image, name, setNativeSize)
	self._v3a3_eliminate_spriteset:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a3IgorSprite(image, name, setNativeSize)
	self._v3a3_igor_spriteset:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a3MarshaSprite(image, name, setNativeSize)
	self._v3a3_marsha_spriteset:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a4MainActivitySprite(image, name, setNativeSize)
	self._v3a4_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a4DungeonSprite(image, name, setNativeSize)
	self._v3a2_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a4LaplaceSprite(image, name, setNativeSize)
	self._v3a4_laplace_spriteset:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a4ChgSprite(image, name, setNativeSize)
	self._v3a4_chg_spriteset:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a5MainActivitySprite(image, name, setNativeSize)
	self._v3a5_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a5DungeonSprite(image, name, setNativeSize)
	self._v3a5_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a5LamonaSprite(image, name, setNativeSize)
	self._v3a5_lamona:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a5SchoolStartSprite(image, name, setNativeSize)
	self._v3a5_schoolstart:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a6MainActivitySprite(image, name, setNativeSize)
	self._v3a6_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a6DungeonSprite(image, name, setNativeSize)
	self._v3a6_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a6YaMiSprite(image, name, setNativeSize)
	self._v3a6_dormitorymode_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setAVGSpellingSprite(image, name, setNativeSize)
	self._avg_spelling_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a7MainActivitySprite(image, name, setNativeSize)
	self._v3a7_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSodacheSprite(image, name, setNativeSize)
	self._sodache:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSodache2Sprite(image, name, setNativeSize)
	self._sodache2:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSodache3Sprite(image, name, setNativeSize)
	self._sodache3:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a7Activity3ndSprite(image, name, setNativeSize)
	self._v3a7_activity3nd_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a7TeachingSystemSprite(image, name, setNativeSize)
	self._v3a7_teaching_system:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setTravelGoSprite(image, name, setNativeSize)
	self.v3a7_xiaoruiannong_spriteset:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a7WmzSprite(image, name, setNativeSize)
	self._v3a7_wmz_spriteset:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a8MainActivitySprite(image, name, setNativeSize)
	self._v3a8_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a9MainActivitySprite(image, name, setNativeSize)
	self._v3a9_main_activity:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a9HedoneSprite(image, name, setNativeSize)
	self._v3a9_hedone_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a9RacingSprite(image, name, setNativeSize)
	self._v3a9_racing_sprit:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a8DungeonSprite(image, name, setNativeSize)
	self._v3a8_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setVAFixedDungeonSprite(image, name, setNativeSize)
	self._v3a2_dungeon_sprite:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setV3a8DianJiShiSprite(image, name, setNativeSize)
	self._v3a8_dianjishi_spriteset:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSp02AtomicDungeonElementSprite(image, name, setNativeSize)
	self._sp02_atomicdungeonelement:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSp02AtomicIconSprite(image, name, setNativeSize)
	self._sp02_atomicIcon:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSp02AtomicActivityIconSprite(image, name, setNativeSize)
	self._sp02_atomicActivityIcon:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setSp02PaoMianIconSprite(image, name, setNativeSize)
	self._sp02_paomian:setSprite(image, name, setNativeSize)
end

function UISpriteSetMgr:setAbyssSprite(image, name, setNativeSize, alpha)
	self._abyss:setSprite(image, name, setNativeSize, alpha)
end

function UISpriteSetMgr:setV3a9NaxiSuosiSprite(image, name, setNativeSize, alpha)
	self._v3a9_naxisuosi:setSprite(image, name, setNativeSize, alpha)
end

function UISpriteSetMgr:tryDispose()
	for i, v in ipairs(self._spriteSetList) do
		v:tryDispose()
	end
end

UISpriteSetMgr.instance = UISpriteSetMgr.New()

return UISpriteSetMgr
