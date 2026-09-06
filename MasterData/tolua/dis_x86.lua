-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/ToLua/Lua/jit/dis_x86.lua

local type = type
local sub, byte, format = string.sub, string.byte, string.format
local match, gmatch, gsub = string.match, string.gmatch, string.gsub
local lower, rep = string.lower, string.rep
local bit = require("bit")
local tohex = bit.tohex
local map_opc1_32 = {
	[0] = "addBmr",
	"addVmr",
	"addBrm",
	"addVrm",
	"addBai",
	"addVai",
	"push es",
	"pop es",
	"orBmr",
	"orVmr",
	"orBrm",
	"orVrm",
	"orBai",
	"orVai",
	"push cs",
	"opc2*",
	"adcBmr",
	"adcVmr",
	"adcBrm",
	"adcVrm",
	"adcBai",
	"adcVai",
	"push ss",
	"pop ss",
	"sbbBmr",
	"sbbVmr",
	"sbbBrm",
	"sbbVrm",
	"sbbBai",
	"sbbVai",
	"push ds",
	"pop ds",
	"andBmr",
	"andVmr",
	"andBrm",
	"andVrm",
	"andBai",
	"andVai",
	"es:seg",
	"daa",
	"subBmr",
	"subVmr",
	"subBrm",
	"subVrm",
	"subBai",
	"subVai",
	"cs:seg",
	"das",
	"xorBmr",
	"xorVmr",
	"xorBrm",
	"xorVrm",
	"xorBai",
	"xorVai",
	"ss:seg",
	"aaa",
	"cmpBmr",
	"cmpVmr",
	"cmpBrm",
	"cmpVrm",
	"cmpBai",
	"cmpVai",
	"ds:seg",
	"aas",
	"incVR",
	"incVR",
	"incVR",
	"incVR",
	"incVR",
	"incVR",
	"incVR",
	"incVR",
	"decVR",
	"decVR",
	"decVR",
	"decVR",
	"decVR",
	"decVR",
	"decVR",
	"decVR",
	"pushUR",
	"pushUR",
	"pushUR",
	"pushUR",
	"pushUR",
	"pushUR",
	"pushUR",
	"pushUR",
	"popUR",
	"popUR",
	"popUR",
	"popUR",
	"popUR",
	"popUR",
	"popUR",
	"popUR",
	"sz*pushaw,pusha",
	"sz*popaw,popa",
	"boundVrm",
	"arplWmr",
	"fs:seg",
	"gs:seg",
	"o16:",
	"a16",
	"pushUi",
	"imulVrmi",
	"pushBs",
	"imulVrms",
	"insb",
	"insVS",
	"outsb",
	"outsVS",
	"joBj",
	"jnoBj",
	"jbBj",
	"jnbBj",
	"jzBj",
	"jnzBj",
	"jbeBj",
	"jaBj",
	"jsBj",
	"jnsBj",
	"jpeBj",
	"jpoBj",
	"jlBj",
	"jgeBj",
	"jleBj",
	"jgBj",
	"arith!Bmi",
	"arith!Vmi",
	"arith!Bmi",
	"arith!Vms",
	"testBmr",
	"testVmr",
	"xchgBrm",
	"xchgVrm",
	"movBmr",
	"movVmr",
	"movBrm",
	"movVrm",
	"movVmg",
	"leaVrm",
	"movWgm",
	"popUm",
	"nop*xchgVaR|pause|xchgWaR|repne nop",
	"xchgVaR",
	"xchgVaR",
	"xchgVaR",
	"xchgVaR",
	"xchgVaR",
	"xchgVaR",
	"xchgVaR",
	"sz*cbw,cwde,cdqe",
	"sz*cwd,cdq,cqo",
	"call farViw",
	"wait",
	"sz*pushfw,pushf",
	"sz*popfw,popf",
	"sahf",
	"lahf",
	"movBao",
	"movVao",
	"movBoa",
	"movVoa",
	"movsb",
	"movsVS",
	"cmpsb",
	"cmpsVS",
	"testBai",
	"testVai",
	"stosb",
	"stosVS",
	"lodsb",
	"lodsVS",
	"scasb",
	"scasVS",
	"movBRi",
	"movBRi",
	"movBRi",
	"movBRi",
	"movBRi",
	"movBRi",
	"movBRi",
	"movBRi",
	"movVRI",
	"movVRI",
	"movVRI",
	"movVRI",
	"movVRI",
	"movVRI",
	"movVRI",
	"movVRI",
	"shift!Bmu",
	"shift!Vmu",
	"retBw",
	"ret",
	"vex*3$lesVrm",
	"vex*2$ldsVrm",
	"movBmi",
	"movVmi",
	"enterBwu",
	"leave",
	"retfBw",
	"retf",
	"int3",
	"intBu",
	"into",
	"iretVS",
	"shift!Bm1",
	"shift!Vm1",
	"shift!Bmc",
	"shift!Vmc",
	"aamBu",
	"aadBu",
	"salc",
	"xlatb",
	"fp*0",
	"fp*1",
	"fp*2",
	"fp*3",
	"fp*4",
	"fp*5",
	"fp*6",
	"fp*7",
	"loopneBj",
	"loopeBj",
	"loopBj",
	"sz*jcxzBj,jecxzBj,jrcxzBj",
	"inBau",
	"inVau",
	"outBua",
	"outVua",
	"callVj",
	"jmpVj",
	"jmp farViw",
	"jmpBj",
	"inBad",
	"inVad",
	"outBda",
	"outVda",
	"lock:",
	"int1",
	"repne:rep",
	"rep:",
	"hlt",
	"cmc",
	"testb!Bm",
	"testv!Vm",
	"clc",
	"stc",
	"cli",
	"sti",
	"cld",
	"std",
	"incb!Bm",
	"incd!Vm"
}

assert(#map_opc1_32 == 255)

local map_opc1_64 = setmetatable({
	[96] = false,
	[7] = false,
	[39] = false,
	[66] = "rex*x",
	[22] = false,
	[97] = false,
	[31] = false,
	[69] = "rex*rb",
	[103] = "a32:",
	[206] = false,
	[130] = false,
	[68] = "rex*r",
	[154] = false,
	[30] = false,
	[197] = "vex*2",
	[71] = "rex*rxb",
	[6] = false,
	[23] = false,
	[70] = "rex*rx",
	[74] = "rex*wx",
	[196] = "vex*3",
	[75] = "rex*wxb",
	[72] = "rex*w",
	[14] = false,
	[73] = "rex*wb",
	[78] = "rex*wrx",
	[79] = "rex*wrxb",
	[47] = false,
	[76] = "rex*wr",
	[55] = false,
	[77] = "rex*wrb",
	[63] = false,
	[214] = false,
	[212] = false,
	[65] = "rex*b",
	[213] = false,
	[98] = false,
	[64] = "rex*",
	[234] = false,
	[99] = "movsxdVrDmt",
	[67] = "rex*xb"
}, {
	__index = map_opc1_32
})
local map_opc2 = {
	[0] = "sldt!Dmp",
	"sgdt!Ump",
	"larVrm",
	"lslVrm",
	nil,
	"syscall",
	"clts",
	"sysret",
	"invd",
	"wbinvd",
	nil,
	"ud1",
	nil,
	"$prefetch!Bm",
	"femms",
	"3dnowMrmu",
	"movupsXrm|movssXrvm|movupdXrm|movsdXrvm",
	"movupsXmr|movssXmvr|movupdXmr|movsdXmvr",
	"movhlpsXrm$movlpsXrm|movsldupXrm|movlpdXrm|movddupXrm",
	"movlpsXmr||movlpdXmr",
	"unpcklpsXrvm||unpcklpdXrvm",
	"unpckhpsXrvm||unpckhpdXrvm",
	"movlhpsXrm$movhpsXrm|movshdupXrm|movhpdXrm",
	"movhpsXmr||movhpdXmr",
	"$prefetcht!Bm",
	"hintnopVm",
	"hintnopVm",
	"hintnopVm",
	"hintnopVm",
	"hintnopVm",
	"hintnopVm",
	"hintnopVm",
	"movUmx$",
	"movUmy$",
	"movUxm$",
	"movUym$",
	"movUmz$",
	nil,
	"movUzm$",
	nil,
	"movapsXrm||movapdXrm",
	"movapsXmr||movapdXmr",
	"cvtpi2psXrMm|cvtsi2ssXrvVmt|cvtpi2pdXrMm|cvtsi2sdXrvVmt",
	"movntpsXmr|movntssXmr|movntpdXmr|movntsdXmr",
	"cvttps2piMrXm|cvttss2siVrXm|cvttpd2piMrXm|cvttsd2siVrXm",
	"cvtps2piMrXm|cvtss2siVrXm|cvtpd2piMrXm|cvtsd2siVrXm",
	"ucomissXrm||ucomisdXrm",
	"comissXrm||comisdXrm",
	"wrmsr",
	"rdtsc",
	"rdmsr",
	"rdpmc",
	"sysenter",
	"sysexit",
	nil,
	"getsec",
	"opc3*38",
	nil,
	"opc3*3a",
	nil,
	nil,
	nil,
	nil,
	nil,
	"cmovoVrm",
	"cmovnoVrm",
	"cmovbVrm",
	"cmovnbVrm",
	"cmovzVrm",
	"cmovnzVrm",
	"cmovbeVrm",
	"cmovaVrm",
	"cmovsVrm",
	"cmovnsVrm",
	"cmovpeVrm",
	"cmovpoVrm",
	"cmovlVrm",
	"cmovgeVrm",
	"cmovleVrm",
	"cmovgVrm",
	"movmskpsVrXm$||movmskpdVrXm$",
	"sqrtpsXrm|sqrtssXrm|sqrtpdXrm|sqrtsdXrm",
	"rsqrtpsXrm|rsqrtssXrvm",
	"rcppsXrm|rcpssXrvm",
	"andpsXrvm||andpdXrvm",
	"andnpsXrvm||andnpdXrvm",
	"orpsXrvm||orpdXrvm",
	"xorpsXrvm||xorpdXrvm",
	"addpsXrvm|addssXrvm|addpdXrvm|addsdXrvm",
	"mulpsXrvm|mulssXrvm|mulpdXrvm|mulsdXrvm",
	"cvtps2pdXrm|cvtss2sdXrvm|cvtpd2psXrm|cvtsd2ssXrvm",
	"cvtdq2psXrm|cvttps2dqXrm|cvtps2dqXrm",
	"subpsXrvm|subssXrvm|subpdXrvm|subsdXrvm",
	"minpsXrvm|minssXrvm|minpdXrvm|minsdXrvm",
	"divpsXrvm|divssXrvm|divpdXrvm|divsdXrvm",
	"maxpsXrvm|maxssXrvm|maxpdXrvm|maxsdXrvm",
	"punpcklbwPrvm",
	"punpcklwdPrvm",
	"punpckldqPrvm",
	"packsswbPrvm",
	"pcmpgtbPrvm",
	"pcmpgtwPrvm",
	"pcmpgtdPrvm",
	"packuswbPrvm",
	"punpckhbwPrvm",
	"punpckhwdPrvm",
	"punpckhdqPrvm",
	"packssdwPrvm",
	"||punpcklqdqXrvm",
	"||punpckhqdqXrvm",
	"movPrVSm",
	"movqMrm|movdquXrm|movdqaXrm",
	"pshufwMrmu|pshufhwXrmu|pshufdXrmu|pshuflwXrmu",
	"pshiftw!Pvmu",
	"pshiftd!Pvmu",
	"pshiftq!Mvmu||pshiftdq!Xvmu",
	"pcmpeqbPrvm",
	"pcmpeqwPrvm",
	"pcmpeqdPrvm",
	"emms*|",
	"vmreadUmr||extrqXmuu$|insertqXrmuu$",
	"vmwriteUrm||extrqXrm$|insertqXrm$",
	nil,
	nil,
	"||haddpdXrvm|haddpsXrvm",
	"||hsubpdXrvm|hsubpsXrvm",
	"movVSmMr|movqXrm|movVSmXr",
	"movqMmr|movdquXmr|movdqaXmr",
	"joVj",
	"jnoVj",
	"jbVj",
	"jnbVj",
	"jzVj",
	"jnzVj",
	"jbeVj",
	"jaVj",
	"jsVj",
	"jnsVj",
	"jpeVj",
	"jpoVj",
	"jlVj",
	"jgeVj",
	"jleVj",
	"jgVj",
	"setoBm",
	"setnoBm",
	"setbBm",
	"setnbBm",
	"setzBm",
	"setnzBm",
	"setbeBm",
	"setaBm",
	"setsBm",
	"setnsBm",
	"setpeBm",
	"setpoBm",
	"setlBm",
	"setgeBm",
	"setleBm",
	"setgBm",
	"push fs",
	"pop fs",
	"cpuid",
	"btVmr",
	"shldVmru",
	"shldVmrc",
	nil,
	nil,
	"push gs",
	"pop gs",
	"rsm",
	"btsVmr",
	"shrdVmru",
	"shrdVmrc",
	"fxsave!Dmp",
	"imulVrm",
	"cmpxchgBmr",
	"cmpxchgVmr",
	"$lssVrm",
	"btrVmr",
	"$lfsVrm",
	"$lgsVrm",
	"movzxVrBmt",
	"movzxVrWmt",
	"|popcntVrm",
	"ud2Dp",
	"bt!Vmu",
	"btcVmr",
	"bsfVrm",
	"bsrVrm|lzcntVrm|bsrWrm",
	"movsxVrBmt",
	"movsxVrWmt",
	"xaddBmr",
	"xaddVmr",
	"cmppsXrvmu|cmpssXrvmu|cmppdXrvmu|cmpsdXrvmu",
	"$movntiVmr|",
	"pinsrwPrvWmu",
	"pextrwDrPmu",
	"shufpsXrvmu||shufpdXrvmu",
	"$cmpxchg!Qmp",
	"bswapVR",
	"bswapVR",
	"bswapVR",
	"bswapVR",
	"bswapVR",
	"bswapVR",
	"bswapVR",
	"bswapVR",
	"||addsubpdXrvm|addsubpsXrvm",
	"psrlwPrvm",
	"psrldPrvm",
	"psrlqPrvm",
	"paddqPrvm",
	"pmullwPrvm",
	"|movq2dqXrMm|movqXmr|movdq2qMrXm$",
	"pmovmskbVrMm||pmovmskbVrXm",
	"psubusbPrvm",
	"psubuswPrvm",
	"pminubPrvm",
	"pandPrvm",
	"paddusbPrvm",
	"padduswPrvm",
	"pmaxubPrvm",
	"pandnPrvm",
	"pavgbPrvm",
	"psrawPrvm",
	"psradPrvm",
	"pavgwPrvm",
	"pmulhuwPrvm",
	"pmulhwPrvm",
	"|cvtdq2pdXrm|cvttpd2dqXrm|cvtpd2dqXrm",
	"$movntqMmr||$movntdqXmr",
	"psubsbPrvm",
	"psubswPrvm",
	"pminswPrvm",
	"porPrvm",
	"paddsbPrvm",
	"paddswPrvm",
	"pmaxswPrvm",
	"pxorPrvm",
	"|||lddquXrm",
	"psllwPrvm",
	"pslldPrvm",
	"psllqPrvm",
	"pmuludqPrvm",
	"pmaddwdPrvm",
	"psadbwPrvm",
	"maskmovqMrm||maskmovdquXrm$",
	"psubbPrvm",
	"psubwPrvm",
	"psubdPrvm",
	"psubqPrvm",
	"paddbPrvm",
	"paddwPrvm",
	"padddPrvm",
	"ud"
}

assert(map_opc2[255] == "ud")

local map_opc3 = {
	["38"] = {
		[0] = "pshufbPrvm",
		"phaddwPrvm",
		"phadddPrvm",
		"phaddswPrvm",
		"pmaddubswPrvm",
		"phsubwPrvm",
		"phsubdPrvm",
		"phsubswPrvm",
		"psignbPrvm",
		"psignwPrvm",
		"psigndPrvm",
		"pmulhrswPrvm",
		"||permilpsXrvm",
		"||permilpdXrvm",
		nil,
		nil,
		"||pblendvbXrma",
		nil,
		nil,
		nil,
		"||blendvpsXrma",
		"||blendvpdXrma",
		"||permpsXrvm",
		"||ptestXrm",
		"||broadcastssXrm",
		"||broadcastsdXrm",
		"||broadcastf128XrlXm",
		nil,
		"pabsbPrm",
		"pabswPrm",
		"pabsdPrm",
		nil,
		"||pmovsxbwXrm",
		"||pmovsxbdXrm",
		"||pmovsxbqXrm",
		"||pmovsxwdXrm",
		"||pmovsxwqXrm",
		"||pmovsxdqXrm",
		nil,
		nil,
		"||pmuldqXrvm",
		"||pcmpeqqXrvm",
		"||$movntdqaXrm",
		"||packusdwXrvm",
		"||maskmovpsXrvm",
		"||maskmovpdXrvm",
		"||maskmovpsXmvr",
		"||maskmovpdXmvr",
		"||pmovzxbwXrm",
		"||pmovzxbdXrm",
		"||pmovzxbqXrm",
		"||pmovzxwdXrm",
		"||pmovzxwqXrm",
		"||pmovzxdqXrm",
		"||permdXrvm",
		"||pcmpgtqXrvm",
		"||pminsbXrvm",
		"||pminsdXrvm",
		"||pminuwXrvm",
		"||pminudXrvm",
		"||pmaxsbXrvm",
		"||pmaxsdXrvm",
		"||pmaxuwXrvm",
		"||pmaxudXrvm",
		"||pmulddXrvm",
		"||phminposuwXrm",
		nil,
		nil,
		nil,
		"||psrlvVSXrvm",
		"||psravdXrvm",
		"||psllvVSXrvm",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||pbroadcastdXrlXm",
		"||pbroadcastqXrlXm",
		"||broadcasti128XrlXm",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||pbroadcastbXrlXm",
		"||pbroadcastwXrlXm",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||pmaskmovXrvVSm",
		nil,
		"||pmaskmovVSmXvr",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||aesencXrvm",
		"||aesenclastXrvm",
		"||aesdecXrvm",
		"||aesdeclastXrvm",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"|||crc32TrBmt",
		"|||crc32TrVmt",
		nil,
		nil,
		nil,
		nil,
		nil,
		"| sarxVrmv| shlxVrmv| shrxVrmv"
	},
	["3a"] = {
		[0] = "||permqXrmu",
		"||permpdXrmu",
		"||pblenddXrvmu",
		nil,
		"||permilpsXrmu",
		"||permilpdXrmu",
		"||perm2f128Xrvmu",
		nil,
		"||roundpsXrmu",
		"||roundpdXrmu",
		"||roundssXrvmu",
		"||roundsdXrvmu",
		"||blendpsXrvmu",
		"||blendpdXrvmu",
		"||pblendwXrvmu",
		"palignrPrvmu",
		nil,
		nil,
		nil,
		nil,
		"||pextrbVmXru",
		"||pextrwVmXru",
		"||pextrVmSXru",
		"||extractpsVmXru",
		"||insertf128XrvlXmu",
		"||extractf128XlXmYru",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||pinsrbXrvVmu",
		"||insertpsXrvmu",
		"||pinsrXrvVmuS",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||inserti128Xrvmu",
		"||extracti128XlXmYru",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||dppsXrvmu",
		"||dppdXrvmu",
		"||mpsadbwXrvmu",
		nil,
		"||pclmulqdqXrvmu",
		nil,
		"||perm2i128Xrvmu",
		nil,
		nil,
		nil,
		"||blendvpsXrvmb",
		"||blendvpdXrvmb",
		"||pblendvbXrvmb",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"||pcmpestrmXrmu",
		"||pcmpestriXrmu",
		"||pcmpistrmXrmu",
		"||pcmpistriXrmu",
		[223] = "||aeskeygenassistXrmu",
		[240] = "||| rorxVrmu"
	}
}
local map_opcvm = {
	[217] = "vmmcall",
	[194] = "vmlaunch",
	[222] = "skinit",
	[201] = "mwait",
	[223] = "invlpga",
	[196] = "vmxoff",
	[220] = "stgi",
	[248] = "swapgs",
	[221] = "clgi",
	[249] = "rdtscp",
	[218] = "vmload",
	[193] = "vmcall",
	[219] = "vmsave",
	[200] = "monitor",
	[216] = "vmrun",
	[195] = "vmresume"
}
local map_opcfp = {
	[0] = "faddFm",
	"fmulFm",
	"fcomFm",
	"fcompFm",
	"fsubFm",
	"fsubrFm",
	"fdivFm",
	"fdivrFm",
	"fldFm",
	nil,
	"fstFm",
	"fstpFm",
	"fldenvVm",
	"fldcwWm",
	"fnstenvVm",
	"fnstcwWm",
	"fiaddDm",
	"fimulDm",
	"ficomDm",
	"ficompDm",
	"fisubDm",
	"fisubrDm",
	"fidivDm",
	"fidivrDm",
	"fildDm",
	"fisttpDm",
	"fistDm",
	"fistpDm",
	nil,
	"fld twordFmp",
	nil,
	"fstp twordFmp",
	"faddGm",
	"fmulGm",
	"fcomGm",
	"fcompGm",
	"fsubGm",
	"fsubrGm",
	"fdivGm",
	"fdivrGm",
	"fldGm",
	"fisttpQm",
	"fstGm",
	"fstpGm",
	"frstorDmp",
	nil,
	"fnsaveDmp",
	"fnstswWm",
	"fiaddWm",
	"fimulWm",
	"ficomWm",
	"ficompWm",
	"fisubWm",
	"fisubrWm",
	"fidivWm",
	"fidivrWm",
	"fildWm",
	"fisttpWm",
	"fistWm",
	"fistpWm",
	"fbld twordFmp",
	"fildQm",
	"fbstp twordFmp",
	"fistpQm",
	"faddFf",
	"fmulFf",
	"fcomFf",
	"fcompFf",
	"fsubFf",
	"fsubrFf",
	"fdivFf",
	"fdivrFf",
	"fldFf",
	"fxchFf",
	{
		"fnop"
	},
	nil,
	{
		"fchs",
		"fabs",
		nil,
		nil,
		"ftst",
		"fxam"
	},
	{
		"fld1",
		"fldl2t",
		"fldl2e",
		"fldpi",
		"fldlg2",
		"fldln2",
		"fldz"
	},
	{
		"f2xm1",
		"fyl2x",
		"fptan",
		"fpatan",
		"fxtract",
		"fprem1",
		"fdecstp",
		"fincstp"
	},
	{
		"fprem",
		"fyl2xp1",
		"fsqrt",
		"fsincos",
		"frndint",
		"fscale",
		"fsin",
		"fcos"
	},
	"fcmovbFf",
	"fcmoveFf",
	"fcmovbeFf",
	"fcmovuFf",
	nil,
	{
		nil,
		"fucompp"
	},
	nil,
	nil,
	"fcmovnbFf",
	"fcmovneFf",
	"fcmovnbeFf",
	"fcmovnuFf",
	{
		nil,
		nil,
		"fnclex",
		"fninit"
	},
	"fucomiFf",
	"fcomiFf",
	nil,
	"fadd toFf",
	"fmul toFf",
	nil,
	nil,
	"fsub toFf",
	"fsubr toFf",
	"fdivr toFf",
	"fdiv toFf",
	"ffreeFf",
	nil,
	"fstFf",
	"fstpFf",
	"fucomFf",
	"fucompFf",
	nil,
	nil,
	"faddpFf",
	"fmulpFf",
	nil,
	{
		nil,
		"fcompp"
	},
	"fsubrpFf",
	"fsubpFf",
	"fdivrpFf",
	"fdivpFf",
	nil,
	nil,
	nil,
	nil,
	{
		"fnstsw ax"
	},
	"fucomipFf",
	"fcomipFf"
}

assert(map_opcfp[126] == "fcomipFf")

local map_opcgroup = {
	arith = {
		"add",
		"or",
		"adc",
		"sbb",
		"and",
		"sub",
		"xor",
		"cmp"
	},
	shift = {
		"rol",
		"ror",
		"rcl",
		"rcr",
		"shl",
		"shr",
		"sal",
		"sar"
	},
	testb = {
		"testBmi",
		"testBmi",
		"not",
		"neg",
		"mul",
		"imul",
		"div",
		"idiv"
	},
	testv = {
		"testVmi",
		"testVmi",
		"not",
		"neg",
		"mul",
		"imul",
		"div",
		"idiv"
	},
	incb = {
		"inc",
		"dec"
	},
	incd = {
		"inc",
		"dec",
		"callUmp",
		"$call farDmp",
		"jmpUmp",
		"$jmp farDmp",
		"pushUm"
	},
	sldt = {
		"sldt",
		"str",
		"lldt",
		"ltr",
		"verr",
		"verw"
	},
	sgdt = {
		"vm*$sgdt",
		"vm*$sidt",
		"$lgdt",
		"vm*$lidt",
		"smsw",
		nil,
		"lmsw",
		"vm*$invlpg"
	},
	bt = {
		nil,
		nil,
		nil,
		nil,
		"bt",
		"bts",
		"btr",
		"btc"
	},
	cmpxchg = {
		nil,
		"sz*,cmpxchg8bQmp,cmpxchg16bXmp",
		nil,
		nil,
		nil,
		nil,
		"vmptrld|vmxon|vmclear",
		"vmptrst"
	},
	pshiftw = {
		nil,
		nil,
		"psrlw",
		nil,
		"psraw",
		nil,
		"psllw"
	},
	pshiftd = {
		nil,
		nil,
		"psrld",
		nil,
		"psrad",
		nil,
		"pslld"
	},
	pshiftq = {
		nil,
		nil,
		"psrlq",
		nil,
		nil,
		nil,
		"psllq"
	},
	pshiftdq = {
		nil,
		nil,
		"psrlq",
		"psrldq",
		nil,
		nil,
		"psllq",
		"pslldq"
	},
	fxsave = {
		"$fxsave",
		"$fxrstor",
		"$ldmxcsr",
		"$stmxcsr",
		nil,
		"lfenceDp$",
		"mfenceDp$",
		"sfenceDp$clflush"
	},
	prefetch = {
		"prefetch",
		"prefetchw"
	},
	prefetcht = {
		"prefetchnta",
		"prefetcht0",
		"prefetcht1",
		"prefetcht2"
	}
}
local map_regs = {
	B = {
		"al",
		"cl",
		"dl",
		"bl",
		"ah",
		"ch",
		"dh",
		"bh",
		"r8b",
		"r9b",
		"r10b",
		"r11b",
		"r12b",
		"r13b",
		"r14b",
		"r15b"
	},
	B64 = {
		"al",
		"cl",
		"dl",
		"bl",
		"spl",
		"bpl",
		"sil",
		"dil",
		"r8b",
		"r9b",
		"r10b",
		"r11b",
		"r12b",
		"r13b",
		"r14b",
		"r15b"
	},
	W = {
		"ax",
		"cx",
		"dx",
		"bx",
		"sp",
		"bp",
		"si",
		"di",
		"r8w",
		"r9w",
		"r10w",
		"r11w",
		"r12w",
		"r13w",
		"r14w",
		"r15w"
	},
	D = {
		"eax",
		"ecx",
		"edx",
		"ebx",
		"esp",
		"ebp",
		"esi",
		"edi",
		"r8d",
		"r9d",
		"r10d",
		"r11d",
		"r12d",
		"r13d",
		"r14d",
		"r15d"
	},
	Q = {
		"rax",
		"rcx",
		"rdx",
		"rbx",
		"rsp",
		"rbp",
		"rsi",
		"rdi",
		"r8",
		"r9",
		"r10",
		"r11",
		"r12",
		"r13",
		"r14",
		"r15"
	},
	M = {
		"mm0",
		"mm1",
		"mm2",
		"mm3",
		"mm4",
		"mm5",
		"mm6",
		"mm7",
		"mm0",
		"mm1",
		"mm2",
		"mm3",
		"mm4",
		"mm5",
		"mm6",
		"mm7"
	},
	X = {
		"xmm0",
		"xmm1",
		"xmm2",
		"xmm3",
		"xmm4",
		"xmm5",
		"xmm6",
		"xmm7",
		"xmm8",
		"xmm9",
		"xmm10",
		"xmm11",
		"xmm12",
		"xmm13",
		"xmm14",
		"xmm15"
	},
	Y = {
		"ymm0",
		"ymm1",
		"ymm2",
		"ymm3",
		"ymm4",
		"ymm5",
		"ymm6",
		"ymm7",
		"ymm8",
		"ymm9",
		"ymm10",
		"ymm11",
		"ymm12",
		"ymm13",
		"ymm14",
		"ymm15"
	}
}
local map_segregs = {
	"es",
	"cs",
	"ss",
	"ds",
	"fs",
	"gs",
	"segr6",
	"segr7"
}
local map_sz2n = {
	X = 16,
	Y = 32,
	D = 4,
	W = 2,
	Q = 8,
	M = 8,
	B = 1
}
local map_sz2prefix = {
	G = "qword",
	X = "xword",
	F = "dword",
	Y = "yword",
	Q = "qword",
	M = "qword",
	D = "dword",
	W = "word",
	B = "byte"
}

local function putop(ctx, text, operands)
	local code, pos, hex = ctx.code, ctx.pos, ""
	local hmax = ctx.hexdump

	if hmax > 0 then
		for i = ctx.start, pos - 1 do
			hex = hex .. format("%02X", byte(code, i, i))
		end

		hex = hmax < #hex and sub(hex, 1, hmax) .. ". " or hex .. rep(" ", hmax - #hex + 2)
	end

	if operands then
		text = text .. " " .. operands
	end

	if ctx.o16 then
		text = "o16 " .. text
		ctx.o16 = false
	end

	if ctx.a32 then
		text = "a32 " .. text
		ctx.a32 = false
	end

	if ctx.rep then
		text = ctx.rep .. " " .. text
		ctx.rep = false
	end

	if ctx.rex then
		local t = (ctx.rexw and "w" or "") .. (ctx.rexr and "r" or "") .. (ctx.rexx and "x" or "") .. (ctx.rexb and "b" or "") .. (ctx.vexl and "l" or "")

		if ctx.vexv and ctx.vexv ~= 0 then
			t = t .. "v" .. ctx.vexv
		end

		if t ~= "" then
			text = ctx.rex .. "." .. t .. " " .. gsub(text, "^ ", "")
		elseif ctx.rex == "vex" then
			text = gsub("v" .. text, "^v ", "")
		end

		ctx.rexw = false
		ctx.rexr = false
		ctx.rexx = false
		ctx.rexb = false
		ctx.rex = false
		ctx.vexl = false
		ctx.vexv = false
	end

	if ctx.seg then
		local text2, n = gsub(text, "%[", "[" .. ctx.seg .. ":")

		text = n == 0 and ctx.seg .. " " .. text or text2
		ctx.seg = false
	end

	if ctx.lock then
		text = "lock " .. text
		ctx.lock = false
	end

	local imm = ctx.imm

	if imm then
		local sym = ctx.symtab[imm]

		if sym then
			text = text .. "\t->" .. sym
		end
	end

	ctx.out(format("%08x  %s%s\n", ctx.addr + ctx.start, hex, text))

	ctx.mrm = false
	ctx.vexv = false
	ctx.start = pos
	ctx.imm = nil
end

local function clearprefixes(ctx)
	ctx.o16 = false
	ctx.seg = false
	ctx.lock = false
	ctx.rep = false
	ctx.rexw = false
	ctx.rexr = false
	ctx.rexx = false
	ctx.rexb = false
	ctx.rex = false
	ctx.a32 = false
	ctx.vexl = false
end

local function incomplete(ctx)
	ctx.pos = ctx.stop + 1

	clearprefixes(ctx)

	return putop(ctx, "(incomplete)")
end

local function unknown(ctx)
	clearprefixes(ctx)

	return putop(ctx, "(unknown)")
end

local function getimm(ctx, pos, n)
	if pos + n - 1 > ctx.stop then
		return incomplete(ctx)
	end

	local code = ctx.code

	if n == 1 then
		return (byte(code, pos, pos))
	elseif n == 2 then
		local b1, b2 = byte(code, pos, pos + 1)

		return b1 + b2 * 256
	else
		local b1, b2, b3, b4 = byte(code, pos, pos + 3)
		local imm = b1 + b2 * 256 + b3 * 65536 + b4 * 16777216

		ctx.imm = imm

		return imm
	end
end

local function putpat(ctx, name, pat)
	local operands, regs, sz, mode, sp, rm, sc, rx, sdisp
	local code, pos, stop, vexl = ctx.code, ctx.pos, ctx.stop, ctx.vexl

	for p in gmatch(pat, ".") do
		local x

		if p == "V" or p == "U" then
			if ctx.rexw then
				sz = "Q"
				ctx.rexw = false
			elseif ctx.o16 then
				sz = "W"
				ctx.o16 = false
			else
				sz = p == "U" and ctx.x64 and "Q" or "D"
			end

			regs = map_regs[sz]
		elseif p == "T" then
			if ctx.rexw then
				sz = "Q"
				ctx.rexw = false
			else
				sz = "D"
			end

			regs = map_regs[sz]
		elseif p == "B" then
			sz = "B"
			regs = ctx.rex and map_regs.B64 or map_regs.B
		elseif match(p, "[WDQMXYFG]") then
			sz = p

			if p == "X" and vexl then
				sz = "Y"
				ctx.vexl = false
			end

			regs = map_regs[sz]
		elseif p == "P" then
			sz = ctx.o16 and "X" or "M"
			ctx.o16 = false

			if sz == "X" and vexl then
				sz = "Y"
				ctx.vexl = false
			end

			regs = map_regs[sz]
		elseif p == "S" then
			name = name .. lower(sz)
		elseif p == "s" then
			local imm = getimm(ctx, pos, 1)

			if not imm then
				return
			end

			x = imm <= 127 and format("+0x%02x", imm) or format("-0x%02x", 256 - imm)
			pos = pos + 1
		elseif p == "u" then
			local imm = getimm(ctx, pos, 1)

			if not imm then
				return
			end

			x = format("0x%02x", imm)
			pos = pos + 1
		elseif p == "b" then
			local imm = getimm(ctx, pos, 1)

			if not imm then
				return
			end

			x = regs[imm / 16 + 1]
			pos = pos + 1
		elseif p == "w" then
			local imm = getimm(ctx, pos, 2)

			if not imm then
				return
			end

			x = format("0x%x", imm)
			pos = pos + 2
		elseif p == "o" then
			if ctx.x64 then
				local imm1 = getimm(ctx, pos, 4)

				if not imm1 then
					return
				end

				local imm2 = getimm(ctx, pos + 4, 4)

				if not imm2 then
					return
				end

				x = format("[0x%08x%08x]", imm2, imm1)
				pos = pos + 8
			else
				local imm = getimm(ctx, pos, 4)

				if not imm then
					return
				end

				x = format("[0x%08x]", imm)
				pos = pos + 4
			end
		elseif p == "i" or p == "I" then
			local n = map_sz2n[sz]

			if n == 8 and ctx.x64 and p == "I" then
				local imm1 = getimm(ctx, pos, 4)

				if not imm1 then
					return
				end

				local imm2 = getimm(ctx, pos + 4, 4)

				if not imm2 then
					return
				end

				x = format("0x%08x%08x", imm2, imm1)
			else
				if n == 8 then
					n = 4
				end

				local imm = getimm(ctx, pos, n)

				if not imm then
					return
				end

				if sz == "Q" and (imm < 0 or imm > 2147483647) then
					imm = 4294967296 - imm
					x = format(imm > 65535 and "-0x%08x" or "-0x%x", imm)
				else
					x = format(imm > 65535 and "0x%08x" or "0x%x", imm)
				end
			end

			pos = pos + n
		elseif p == "j" then
			local n = map_sz2n[sz]

			if n == 8 then
				n = 4
			end

			local imm = getimm(ctx, pos, n)

			if not imm then
				return
			end

			if sz == "B" and imm > 127 then
				imm = imm - 256
			elseif imm > 2147483647 then
				imm = imm - 4294967296
			end

			pos = pos + n
			imm = imm + pos + ctx.addr

			if imm > 4294967295 and not ctx.x64 then
				imm = imm - 4294967296
			end

			ctx.imm = imm

			if sz == "W" then
				x = format("word 0x%04x", imm % 65536)
			elseif ctx.x64 then
				local lo = imm % 16777216

				x = format("0x%02x%06x", (imm - lo) / 16777216, lo)
			else
				x = "0x" .. tohex(imm)
			end
		elseif p == "R" then
			local r = byte(code, pos - 1, pos - 1) % 8

			if ctx.rexb then
				r = r + 8
				ctx.rexb = false
			end

			x = regs[r + 1]
		elseif p == "a" then
			x = regs[1]
		elseif p == "c" then
			x = "cl"
		elseif p == "d" then
			x = "dx"
		elseif p == "1" then
			x = "1"
		else
			if not mode then
				mode = ctx.mrm

				if not ctx.mrm then
					if stop < pos then
						return incomplete(ctx)
					end

					mode = byte(code, pos, pos)
					pos = pos + 1
				end

				rm = mode % 8
				mode = (mode - mode % 8) / 8
				sp = mode % 8
				mode = (mode - sp) / 8
				sdisp = ""

				if mode < 3 then
					if rm == 4 then
						if stop < pos then
							return incomplete(ctx)
						end

						sc = byte(code, pos, pos)
						pos = pos + 1
						rm = sc % 8
						sc = (sc - rm) / 8
						rx = sc % 8
						sc = (sc - rx) / 8

						if ctx.rexx then
							rx = rx + 8
							ctx.rexx = false
						end

						if rx == 4 then
							rx = nil
						end
					end

					if mode > 0 or rm == 5 then
						local dsz = mode

						if dsz ~= 1 then
							dsz = 4
						end

						local disp = getimm(ctx, pos, dsz)

						if not disp then
							return
						end

						if mode == 0 then
							rm = nil
						end

						sdisp = (rm or rx or not sc and ctx.x64 and not ctx.a32) and (dsz == 1 and disp > 127 and format("-0x%x", 256 - disp) or disp >= 0 and disp <= 2147483647 and format("+0x%x", disp) or format("-0x%x", 4294967296 - disp)) or format(ctx.x64 and not ctx.a32 and (not (disp >= 0) or not (disp <= 2147483647)) and "0xffffffff%08x" or "0x%08x", disp)
						pos = pos + dsz
					end
				end

				if rm and ctx.rexb then
					rm = rm + 8
					ctx.rexb = false
				end

				if ctx.rexr then
					sp = sp + 8
					ctx.rexr = false
				end
			end

			if p == "m" then
				if mode == 3 then
					x = regs[rm + 1]
				end

				if ctx.a32 then
					if not map_regs.D then
						do
							local aregs = ctx.aregs
							local srm, srx = "", ""

							if rm then
								srm = aregs[rm + 1]
							elseif not sc and ctx.x64 and not ctx.a32 then
								srm = "rip"
							end

							ctx.a32 = false

							if rx then
								if rm then
									srm = srm .. "+"
								end

								srx = aregs[rx + 1]

								if sc > 0 then
									srx = srx .. "*" .. 2^sc
								end
							end

							x = format("[%s%s%s]", srm, srx, sdisp)
						end

						if mode < 3 and (not match(pat, "[aRrgp]") or match(pat, "t")) then
							x = map_sz2prefix[sz] .. " " .. x
						end
					end
				end
			elseif p == "r" then
				x = regs[sp + 1]
			elseif p == "g" then
				x = map_segregs[sp + 1]
			elseif p == "p" then
				-- block empty
			elseif p == "f" then
				x = "st" .. rm
			elseif p == "x" then
				if sp == 0 and ctx.lock and not ctx.x64 then
					x = "CR8"
					ctx.lock = false
				else
					x = "CR" .. sp
				end
			elseif p == "v" then
				if ctx.vexv then
					x = regs[ctx.vexv + 1]
					ctx.vexv = false
				end
			elseif p == "y" then
				x = "DR" .. sp
			elseif p == "z" then
				x = "TR" .. sp
			elseif p == "l" then
				vexl = false
			elseif p == "t" then
				-- block empty
			else
				error("bad pattern `" .. pat .. "'")
			end
		end

		if x then
			operands = operands and operands .. ", " .. x or x
		end
	end

	ctx.pos = pos

	return putop(ctx, name, operands)
end

local map_act

local function getmrm(ctx)
	local mrm = ctx.mrm

	if not mrm then
		local pos = ctx.pos

		if pos > ctx.stop then
			return nil
		end

		mrm = byte(ctx.code, pos, pos)
		ctx.pos = pos + 1
		ctx.mrm = mrm
	end

	return mrm
end

local function dispatch(ctx, opat, patgrp)
	if not opat then
		return unknown(ctx)
	end

	if match(opat, "%|") then
		local p

		if ctx.rep then
			p = ctx.rep == "rep" and "%|([^%|]*)" or "%|[^%|]*%|[^%|]*%|([^%|]*)"
			ctx.rep = false
		elseif ctx.o16 then
			p = "%|[^%|]*%|([^%|]*)"
			ctx.o16 = false
		else
			p = "^[^%|]*"
		end

		opat = match(opat, p)

		if not opat then
			return unknown(ctx)
		end
	end

	if match(opat, "%$") then
		local mrm = getmrm(ctx)

		if not mrm then
			return incomplete(ctx)
		end

		opat = match(opat, mrm >= 192 and "^[^%$]*" or "%$(.*)")

		if opat == "" then
			return unknown(ctx)
		end
	end

	if opat == "" then
		return unknown(ctx)
	end

	local name, pat = match(opat, "^([a-z0-9 ]*)(.*)")

	if pat == "" and patgrp then
		pat = patgrp
	end

	return map_act[sub(pat, 1, 1)](ctx, name, pat)
end

local function dispatchmap(ctx, opcmap)
	local pos = ctx.pos
	local opat = opcmap[byte(ctx.code, pos, pos)]

	pos = pos + 1
	ctx.pos = pos

	return dispatch(ctx, opat)
end

map_act = {
	[""] = function(ctx, name, pat)
		return putop(ctx, name)
	end,
	B = putpat,
	W = putpat,
	D = putpat,
	Q = putpat,
	V = putpat,
	U = putpat,
	T = putpat,
	M = putpat,
	X = putpat,
	P = putpat,
	F = putpat,
	G = putpat,
	Y = putpat,
	[":"] = function(ctx, name, pat)
		ctx[pat == ":" and name or sub(pat, 2)] = name

		if ctx.pos - ctx.start > 5 then
			return unknown(ctx)
		end
	end,
	["*"] = function(ctx, name, pat)
		return map_act[name](ctx, name, sub(pat, 2))
	end,
	["!"] = function(ctx, name, pat)
		local mrm = getmrm(ctx)

		if not mrm then
			return incomplete(ctx)
		end

		return dispatch(ctx, map_opcgroup[name][(mrm - mrm % 8) / 8 % 8 + 1], sub(pat, 2))
	end,
	sz = function(ctx, name, pat)
		if ctx.o16 then
			ctx.o16 = false
		else
			pat = match(pat, ",(.*)")

			if ctx.rexw then
				local p = match(pat, ",(.*)")

				if p then
					pat = p
					ctx.rexw = false
				end
			end
		end

		pat = match(pat, "^[^,]*")

		return dispatch(ctx, pat)
	end,
	opc2 = function(ctx, name, pat)
		return dispatchmap(ctx, map_opc2)
	end,
	opc3 = function(ctx, name, pat)
		return dispatchmap(ctx, map_opc3[pat])
	end,
	vm = function(ctx, name, pat)
		return dispatch(ctx, map_opcvm[ctx.mrm])
	end,
	fp = function(ctx, name, pat)
		local mrm = getmrm(ctx)

		if not mrm then
			return incomplete(ctx)
		end

		local rm = mrm % 8
		local idx = pat * 8 + (mrm - rm) / 8 % 8

		if mrm >= 192 then
			idx = idx + 64
		end

		local opat = map_opcfp[idx]

		if type(opat) == "table" then
			opat = opat[rm + 1]
		end

		return dispatch(ctx, opat)
	end,
	rex = function(ctx, name, pat)
		if ctx.rex then
			return unknown(ctx)
		end

		for p in gmatch(pat, ".") do
			ctx["rex" .. p] = true
		end

		ctx.rex = "rex"
	end,
	vex = function(ctx, name, pat)
		if ctx.rex then
			return unknown(ctx)
		end

		ctx.rex = "vex"

		local pos = ctx.pos

		if ctx.mrm then
			ctx.mrm = nil
			pos = pos - 1
		end

		local b = byte(ctx.code, pos, pos)

		if not b then
			return incomplete(ctx)
		end

		pos = pos + 1

		if b < 128 then
			ctx.rexr = true
		end

		local m = 1

		if pat == "3" then
			m = b % 32
			b = (b - b % 32) / 32

			local nb = b % 2

			b = (b - nb) / 2

			if nb == 0 then
				ctx.rexb = true
			end

			local nx = b % 2

			if nx == 0 then
				ctx.rexx = true
			end

			b = byte(ctx.code, pos, pos)

			if not b then
				return incomplete(ctx)
			end

			pos = pos + 1

			if b >= 128 then
				ctx.rexw = true
			end
		end

		ctx.pos = pos

		local map

		if m == 1 then
			map = map_opc2
		elseif m == 2 then
			map = map_opc3["38"]
		elseif m == 3 then
			map = map_opc3["3a"]
		else
			return unknown(ctx)
		end

		local p = b % 4

		b = (b - p) / 4

		if p == 1 then
			ctx.o16 = "o16"
		elseif p == 2 then
			ctx.rep = "rep"
		elseif p == 3 then
			ctx.rep = "repne"
		end

		local l = b % 2

		b = (b - l) / 2

		if l ~= 0 then
			ctx.vexl = true
		end

		ctx.vexv = (-1 - b) % 16

		return dispatchmap(ctx, map)
	end,
	nop = function(ctx, name, pat)
		return dispatch(ctx, ctx.rex and pat or "nop")
	end,
	emms = function(ctx, name, pat)
		if ctx.rex ~= "vex" then
			return putop(ctx, "emms")
		elseif ctx.vexl then
			ctx.vexl = false

			return putop(ctx, "zeroall")
		else
			return putop(ctx, "zeroupper")
		end
	end
}

local function disass_block(ctx, ofs, len)
	ofs = ofs or 0

	if len then
		if not (ofs + len) then
			local stop = #ctx.code

			ofs = ofs + 1
			ctx.start = ofs
			ctx.pos = ofs
			ctx.stop = stop
			ctx.imm = nil
			ctx.mrm = false

			clearprefixes(ctx)

			while stop >= ctx.pos do
				dispatchmap(ctx, ctx.map1)
			end

			if ctx.pos ~= ctx.start then
				incomplete(ctx)
			end
		end
	end
end

local function create(code, addr, out)
	local ctx = {}

	ctx.code = code
	ctx.addr = (addr or 0) - 1
	ctx.out = out or io.write
	ctx.symtab = {}
	ctx.disass = disass_block
	ctx.hexdump = 16
	ctx.x64 = false
	ctx.map1 = map_opc1_32
	ctx.aregs = map_regs.D

	return ctx
end

local function create64(code, addr, out)
	local ctx = create(code, addr, out)

	ctx.x64 = true
	ctx.map1 = map_opc1_64
	ctx.aregs = map_regs.Q

	return ctx
end

local function disass(code, addr, out)
	create(code, addr, out):disass()
end

local function disass64(code, addr, out)
	create64(code, addr, out):disass()
end

local function regname(r)
	if r < 8 then
		return map_regs.D[r + 1]
	end

	return map_regs.X[r - 7]
end

local function regname64(r)
	if r < 16 then
		return map_regs.Q[r + 1]
	end

	return map_regs.X[r - 15]
end

return {
	create = create,
	create64 = create64,
	disass = disass,
	disass64 = disass64,
	regname = regname,
	regname64 = regname64
}
