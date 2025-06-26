-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/npc/cnpcchat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cnpcchat = {}
cnpcchat.Data = {
[1] = {id = 1, type = 1, chat = "Zzz……", chatTextID = 900030, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[7] = {id = 7, type = 1, chat = "愿寻得镜中实形。", chatTextID = 900036, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[8] = {id = 8, type = 1, chat = "你不该在这里的。", chatTextID = 900037, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[9] = {id = 9, type = 1, chat = "这可是个天大的秘密，不可以告诉其他人哦！", chatTextID = 900038, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[10] = {id = 10, type = 1, chat = "何时才能回到魂牵梦绕的故乡。", chatTextID = 900039, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[11] = {id = 11, type = 1, chat = "您的善意终将得到回报。", chatTextID = 900040, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[12] = {id = 12, type = 2, chat = "我的悔恨无法传递给哥哥了。", chatTextID = 900041, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[13] = {id = 13, type = 1, chat = "小女孩，快离开……", chatTextID = 900042, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[14] = {id = 14, type = 1, chat = "别再打扰我了。", chatTextID = 900043, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[15] = {id = 15, type = 2, chat = "骑士先生就在我旁边，他应该知道如何进入遗迹内部。", chatTextID = 900044, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[16] = {id = 16, type = 1, chat = "······", chatTextID = 900045, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[17] = {id = 17, type = 1, chat = "感谢你出手相助，那么，期待我们下次见面。", chatTextID = 900046, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[18] = {id = 18, type = 1, chat = "那边的那个人类，似乎只是昏了过去，生命并无大碍。", chatTextID = 900047, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[19] = {id = 19, type = 1, chat = "······", chatTextID = 900048, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[20] = {id = 20, type = 1, chat = "居然要去山顶，真是有趣的家伙。", chatTextID = 900049, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[21] = {id = 21, type = 1, chat = "嗯？女孩？这里可不是你玩耍的地方，快点下山吧！", chatTextID = 900050, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[22] = {id = 22, type = 1, chat = "雪很大，要当心啊！", chatTextID = 900051, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[23] = {id = 23, type = 1, chat = "这么大的风雪，过不了多久，就不再会有猎物了。", chatTextID = 900052, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[24] = {id = 24, type = 1, chat = "好吧，我也只能祝你好运了，朋友。", chatTextID = 900053, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[25] = {id = 25, type = 1, chat = "前面十分危险，可要当心啊！", chatTextID = 900054, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[26] = {id = 26, type = 1, chat = "雪风的意志，请庇佑这个孩子前行！", chatTextID = 900055, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[27] = {id = 27, type = 1, chat = "又见到你了，我的朋友。", chatTextID = 900056, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[28] = {id = 28, type = 1, chat = "那么，我的朋友，有缘再会了。", chatTextID = 900057, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[29] = {id = 29, type = 1, chat = "放心交给我吧，我会照顾好她的，安心前进吧！", chatTextID = 900058, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[30] = {id = 30, type = 1, chat = "住在东南边屋子的安迪答应帮我做根拐杖，可没有合适的木材……", chatTextID = 900059, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[31] = {id = 31, type = 1, chat = "一定要帮我教训那些偷粮贼！", chatTextID = 900060, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[32] = {id = 32, type = 1, chat = "女孩啊，去山顶会遭到恶神的惩罚的，千万别去啊。", chatTextID = 900061, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[33] = {id = 33, type = 1, chat = "女孩，千万别枉送了性命啊。", chatTextID = 900062, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[34] = {id = 34, type = 1, chat = "多亏有你帮忙做拐杖，真是太感谢你了。", chatTextID = 900063, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[35] = {id = 35, type = 1, chat = "呜……别抓我！", chatTextID = 900064, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[36] = {id = 36, type = 1, chat = "谢谢你救了我。", chatTextID = 900065, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[37] = {id = 37, type = 2, chat = "我的悔恨终于能够传递给哥哥了。", chatTextID = 900066, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[38] = {id = 38, type = 0, chat = "她看上去暂时失去意识了。", chatTextID = 900067, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[39] = {id = 39, type = 1, chat = "有找到我的曲谱吗？", chatTextID = 900068, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[40] = {id = 40, type = 1, chat = "前面的传送阵是单向通行的，记住曾经走过的路就不会迷路。", chatTextID = 900069, time = "0.05", SkipTime = 8, volume_id = 0}
, 
[41] = {id = 41, type = 1, chat = "为什么会这样……", chatTextID = 900070, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[42] = {id = 42, type = 1, chat = "这些魔物到底是从哪里来的……", chatTextID = 900071, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[43] = {id = 43, type = 1, chat = "村口外又出现魔物了，你要小心啊！", chatTextID = 900072, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[44] = {id = 44, type = 1, chat = "幸好有你在，不然我们……", chatTextID = 900073, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[45] = {id = 45, type = 1, chat = "不知道德亚丝那边怎么样了……", chatTextID = 900074, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[46] = {id = 46, type = 1, chat = "女孩，前面很危险的，早点回村子里吧。", chatTextID = 900075, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[47] = {id = 47, type = 1, chat = "回村落去吧，我会用自己这双眼睛去亲自确认事实的。", chatTextID = 900076, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[48] = {id = 48, type = 1, chat = "我相信你们，多年以来的矛盾也许就要解开了。", chatTextID = 900077, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[49] = {id = 49, type = 1, chat = "有找到食物吗？应该就埋在附近才对……", chatTextID = 900078, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[50] = {id = 50, type = 2, chat = "你如果有需要，就来塔底层的工坊找我吧。", chatTextID = 900080, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[51] = {id = 51, type = 1, chat = "我和教会的人打过交道，他们都是心机很深的人。别轻易相信他们。", chatTextID = 900081, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[52] = {id = 52, type = 1, chat = "这里不欢迎上层的魔法师！", chatTextID = 900082, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[53] = {id = 53, type = 1, chat = "我已经没有粮食了，求求你们，别来了！", chatTextID = 900083, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[54] = {id = 54, type = 1, chat = "我们已经没有东西可以上交了，求求你们放过我们吧。", chatTextID = 900084, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[55] = {id = 55, type = 1, chat = "隔壁的村子就是被上层的魔法师摧毁了，所有人都被杀害了……", chatTextID = 900085, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[56] = {id = 56, type = 1, chat = "  我们把你当成了上层的那些家伙，他们从不劳作，只知道抢走我们的劳动成果！", chatTextID = 900086, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[57] = {id = 57, type = 1, chat = "浮岛不断上升，粮食的产量越来越少，这样下去，大家都会饿死的。", chatTextID = 900087, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[58] = {id = 58, type = 1, chat = "现在出现了越来越多的魔物，我们只能依靠上层的魔法师，因此才对他们的暴行忍气吞声。 ", chatTextID = 900088, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[59] = {id = 59, type = 1, chat = "我们的祖先原本生活在地面上，听说后来出现了大量的魔物，守护者大人施法让嘉庇艾尔升起，这样魔物就不能攻击我们了。", chatTextID = 900089, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[60] = {id = 60, type = 1, chat = "如果没什么事，你还是快点离开这里吧！我们不欢迎外地人。", chatTextID = 900093, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[61] = {id = 61, type = 1, chat = "信仰守护者大人吧。", chatTextID = 900094, time = "0.05", SkipTime = 5, volume_id = 0}
, 
[62] = {id = 62, type = 1, chat = "可不要告诉其他人呀。", chatTextID = 900095, time = "0.05", SkipTime = 5, volume_id = 0}
}
cnpcchat.AllIds = {1, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62}
return cnpcchat

