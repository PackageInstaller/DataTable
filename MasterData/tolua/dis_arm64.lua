-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/ToLua/Lua/jit/dis_arm64.lua

local type = type
local sub, byte, format = string.sub, string.byte, string.format
local match, gmatch, gsub = string.match, string.gmatch, string.gsub
local concat = table.concat
local bit = require("bit")
local band, bor, bxor, tohex = bit.band, bit.bor, bit.bxor, bit.tohex
local lshift, rshift, arshift = bit.lshift, bit.rshift, bit.arshift
local ror = bit.ror
local map_adr = {
	[0] = "adrDBx",
	"adrpDBx",
	shift = 31,
	mask = 1
}
local map_addsubi = {
	[0] = "add|movDNIg",
	"adds|cmnD0NIg",
	"subDNIg",
	"subs|cmpD0NIg",
	shift = 29,
	mask = 3
}
local map_logi = {
	[0] = {
		false,
		shift = 22,
		mask = 1,
		[0] = {
			[0] = "andDNig",
			"orr|movDN0ig",
			"eorDNig",
			"ands|tstD0Nig",
			shift = 29,
			mask = 3
		}
	},
	{
		[0] = "andDNig",
		"orr|movDN0ig",
		"eorDNig",
		"ands|tstD0Nig",
		shift = 29,
		mask = 3
	},
	shift = 31,
	mask = 1
}
local map_movwi = {
	[0] = {
		false,
		shift = 22,
		mask = 1,
		[0] = {
			[0] = "movnDWRg",
			false,
			"movz|movDYRg",
			"movkDWRg",
			shift = 29,
			mask = 3
		}
	},
	{
		[0] = "movnDWRg",
		false,
		"movz|movDYRg",
		"movkDWRg",
		shift = 29,
		mask = 3
	},
	shift = 31,
	mask = 1
}
local map_bitf = {
	[0] = {
		shift = 22,
		mask = 1,
		[0] = {
			[0] = "sbfm|sbfiz|sbfx|asr|sxtw|sxth|sxtbDN12w",
			"bfm|bfi|bfxilDN13w",
			"ubfm|ubfiz|ubfx|lsr|lsl|uxth|uxtbDN12w",
			shift = 29,
			mask = 3
		}
	},
	{
		{
			[0] = "sbfm|sbfiz|sbfx|asr|sxtw|sxth|sxtbDN12x",
			"bfm|bfi|bfxilDN13x",
			"ubfm|ubfiz|ubfx|lsr|lsl|uxth|uxtbDN12x",
			shift = 29,
			mask = 3
		},
		shift = 22,
		mask = 1
	},
	shift = 31,
	mask = 1
}
local map_datai = {
	[0] = map_adr,
	map_adr,
	map_addsubi,
	false,
	map_logi,
	map_movwi,
	map_bitf,
	{
		[0] = "extr|rorDNM4w",
		[65664] = "extr|rorDNM4x",
		[65665] = "extr|rorDNM4x",
		shift = 15,
		mask = 114881
	},
	shift = 23,
	mask = 7
}
local map_logsr = {
	[0] = {
		false,
		shift = 15,
		mask = 1,
		[0] = {
			[0] = {
				[0] = "andDNMSg",
				"bicDNMSg",
				"andDNMSg",
				"bicDNMSg",
				"andDNMSg",
				"bicDNMSg",
				"andDNMg",
				"bicDNMg",
				shift = 21,
				mask = 7
			},
			{
				[0] = "orr|movDN0MSg",
				"orn|mvnDN0MSg",
				"orr|movDN0MSg",
				"orn|mvnDN0MSg",
				"orr|movDN0MSg",
				"orn|mvnDN0MSg",
				"orr|movDN0Mg",
				"orn|mvnDN0Mg",
				shift = 21,
				mask = 7
			},
			{
				[0] = "eorDNMSg",
				"eonDNMSg",
				"eorDNMSg",
				"eonDNMSg",
				"eorDNMSg",
				"eonDNMSg",
				"eorDNMg",
				"eonDNMg",
				shift = 21,
				mask = 7
			},
			{
				[0] = "ands|tstD0NMSg",
				"bicsDNMSg",
				"ands|tstD0NMSg",
				"bicsDNMSg",
				"ands|tstD0NMSg",
				"bicsDNMSg",
				"ands|tstD0NMg",
				"bicsDNMg",
				shift = 21,
				mask = 7
			},
			shift = 29,
			mask = 3
		}
	},
	{
		[0] = {
			[0] = "andDNMSg",
			"bicDNMSg",
			"andDNMSg",
			"bicDNMSg",
			"andDNMSg",
			"bicDNMSg",
			"andDNMg",
			"bicDNMg",
			shift = 21,
			mask = 7
		},
		{
			[0] = "orr|movDN0MSg",
			"orn|mvnDN0MSg",
			"orr|movDN0MSg",
			"orn|mvnDN0MSg",
			"orr|movDN0MSg",
			"orn|mvnDN0MSg",
			"orr|movDN0Mg",
			"orn|mvnDN0Mg",
			shift = 21,
			mask = 7
		},
		{
			[0] = "eorDNMSg",
			"eonDNMSg",
			"eorDNMSg",
			"eonDNMSg",
			"eorDNMSg",
			"eonDNMSg",
			"eorDNMg",
			"eonDNMg",
			shift = 21,
			mask = 7
		},
		{
			[0] = "ands|tstD0NMSg",
			"bicsDNMSg",
			"ands|tstD0NMSg",
			"bicsDNMSg",
			"ands|tstD0NMSg",
			"bicsDNMSg",
			"ands|tstD0NMg",
			"bicsDNMg",
			shift = 21,
			mask = 7
		},
		shift = 29,
		mask = 3
	},
	shift = 31,
	mask = 1
}
local map_assh = {
	[0] = {
		false,
		shift = 15,
		mask = 1,
		[0] = {
			[0] = {
				[0] = "addDNMSg",
				"addDNMSg",
				"addDNMSg",
				"addDNMg",
				shift = 22,
				mask = 3
			},
			{
				[0] = "adds|cmnD0NMSg",
				"adds|cmnD0NMSg",
				"adds|cmnD0NMSg",
				"adds|cmnD0NMg",
				shift = 22,
				mask = 3
			},
			{
				[0] = "sub|negDN0MSg",
				"sub|negDN0MSg",
				"sub|negDN0MSg",
				"sub|negDN0Mg",
				shift = 22,
				mask = 3
			},
			{
				[0] = "subs|cmp|negsD0N0MzSg",
				"subs|cmp|negsD0N0MzSg",
				"subs|cmp|negsD0N0MzSg",
				"subs|cmp|negsD0N0Mzg",
				shift = 22,
				mask = 3
			},
			shift = 29,
			mask = 3
		}
	},
	{
		[0] = {
			[0] = "addDNMSg",
			"addDNMSg",
			"addDNMSg",
			"addDNMg",
			shift = 22,
			mask = 3
		},
		{
			[0] = "adds|cmnD0NMSg",
			"adds|cmnD0NMSg",
			"adds|cmnD0NMSg",
			"adds|cmnD0NMg",
			shift = 22,
			mask = 3
		},
		{
			[0] = "sub|negDN0MSg",
			"sub|negDN0MSg",
			"sub|negDN0MSg",
			"sub|negDN0Mg",
			shift = 22,
			mask = 3
		},
		{
			[0] = "subs|cmp|negsD0N0MzSg",
			"subs|cmp|negsD0N0MzSg",
			"subs|cmp|negsD0N0MzSg",
			"subs|cmp|negsD0N0Mzg",
			shift = 22,
			mask = 3
		},
		shift = 29,
		mask = 3
	},
	shift = 31,
	mask = 1
}
local map_addsubsh = {
	[0] = map_assh,
	map_assh,
	map_assh,
	shift = 22,
	mask = 3
}
local map_addsubex = {
	shift = 22,
	mask = 3,
	[0] = {
		[0] = "addDNMXg",
		"adds|cmnD0NMXg",
		"subDNMXg",
		"subs|cmpD0NMzXg",
		shift = 29,
		mask = 3
	}
}
local map_addsubc = {
	shift = 10,
	mask = 63,
	[0] = {
		[0] = "adcDNMg",
		"adcsDNMg",
		"sbc|ngcDN0Mg",
		"sbcs|ngcsDN0Mg",
		shift = 29,
		mask = 3
	}
}
local map_ccomp = {
	shift = 4,
	mask = 1,
	[0] = {
		shift = 10,
		mask = 3,
		[0] = {
			"ccmnNMVCg",
			false,
			"ccmpNMVCg",
			shift = 29,
			mask = 3
		},
		[2] = {
			"ccmnN5VCg",
			false,
			"ccmpN5VCg",
			shift = 29,
			mask = 3
		}
	}
}
local map_csel = {
	shift = 11,
	mask = 1,
	[0] = {
		[0] = {
			[0] = "cselDNMzCg",
			false,
			"csinv|cinv|csetmDNMcg",
			false,
			shift = 29,
			mask = 3
		},
		{
			[0] = "csinc|cinc|csetDNMcg",
			false,
			"csneg|cnegDNMcg",
			false,
			shift = 29,
			mask = 3
		},
		shift = 10,
		mask = 1
	}
}
local map_data1s = {
	shift = 29,
	mask = 1,
	[0] = {
		[0] = {
			[0] = "rbitDNg",
			"rev16DNg",
			"revDNw",
			false,
			"clzDNg",
			"clsDNg",
			shift = 10,
			mask = 2047
		},
		{
			[0] = "rbitDNg",
			"rev16DNg",
			"rev32DNx",
			"revDNx",
			"clzDNg",
			"clsDNg",
			shift = 10,
			mask = 2047
		},
		shift = 31,
		mask = 1
	}
}
local map_data2s = {
	shift = 29,
	mask = 1,
	[0] = {
		false,
		"udivDNMg",
		"sdivDNMg",
		false,
		false,
		false,
		false,
		"lslDNMg",
		"lsrDNMg",
		"asrDNMg",
		"rorDNMg",
		shift = 10,
		mask = 63
	}
}
local map_data3s = {
	false,
	false,
	false,
	[0] = {
		shift = 21,
		mask = 7,
		[0] = {
			[0] = "madd|mulDNMA0g",
			"msub|mnegDNMA0g",
			shift = 15,
			mask = 1
		}
	},
	{
		[0] = {
			[0] = "madd|mulDNMA0g",
			"smaddl|smullDxNMwA0x",
			"smulhDNMx",
			false,
			false,
			"umaddl|umullDxNMwA0x",
			"umulhDNMx",
			shift = 21,
			mask = 7
		},
		{
			[0] = "msub|mnegDNMA0g",
			"smsubl|smneglDxNMwA0x",
			false,
			false,
			false,
			"umsubl|umneglDxNMwA0x",
			shift = 21,
			mask = 7
		},
		shift = 15,
		mask = 1
	},
	shift = 29,
	mask = 7
}
local map_datar = {
	[0] = {
		[0] = map_logsr,
		{
			[0] = map_addsubsh,
			map_addsubex,
			shift = 21,
			mask = 1
		},
		shift = 24,
		mask = 1
	},
	{
		false,
		[0] = map_addsubc,
		map_ccomp,
		false,
		map_csel,
		false,
		{
			[0] = map_data2s,
			map_data1s,
			shift = 30,
			mask = 1
		},
		false,
		map_data3s,
		map_data3s,
		map_data3s,
		map_data3s,
		map_data3s,
		map_data3s,
		map_data3s,
		map_data3s,
		shift = 21,
		mask = 15
	},
	shift = 28,
	mask = 1
}
local map_lrl = {
	[0] = {
		[0] = "ldrDwB",
		"ldrDxB",
		"ldrswDxB",
		shift = 30,
		mask = 3
	},
	{
		[0] = "ldrDsB",
		"ldrDdB",
		shift = 30,
		mask = 3
	},
	shift = 26,
	mask = 1
}
local map_lsriind = {
	[0] = {
		shift = 26,
		mask = 1,
		[0] = {
			[0] = "strbDwzL",
			"ldrbDwzL",
			"ldrsbDxzL",
			"ldrsbDwzL",
			shift = 22,
			mask = 3
		}
	},
	{
		shift = 26,
		mask = 1,
		[0] = {
			[0] = "strhDwzL",
			"ldrhDwzL",
			"ldrshDxzL",
			"ldrshDwzL",
			shift = 22,
			mask = 3
		}
	},
	{
		[0] = {
			[0] = "strDwzL",
			"ldrDwzL",
			"ldrswDxzL",
			shift = 22,
			mask = 3
		},
		{
			[0] = "strDszL",
			"ldrDszL",
			shift = 22,
			mask = 3
		},
		shift = 26,
		mask = 1
	},
	{
		[0] = {
			[0] = "strDxzL",
			"ldrDxzL",
			shift = 22,
			mask = 3
		},
		{
			[0] = "strDdzL",
			"ldrDdzL",
			shift = 22,
			mask = 3
		},
		shift = 26,
		mask = 1
	},
	shift = 30,
	mask = 3
}
local map_lsriro = {
	[0] = {
		[0] = {
			shift = 26,
			mask = 1,
			[0] = {
				[0] = {
					[0] = "sturbDwK",
					"ldurbDwK",
					shift = 22,
					mask = 3
				},
				{
					[0] = "sturhDwK",
					"ldurhDwK",
					shift = 22,
					mask = 3
				},
				{
					[0] = "sturDwK",
					"ldurDwK",
					shift = 22,
					mask = 3
				},
				{
					[0] = "sturDxK",
					"ldurDxK",
					shift = 22,
					mask = 3
				},
				shift = 30,
				mask = 3
			}
		},
		map_lsriind,
		false,
		map_lsriind,
		shift = 10,
		mask = 3
	},
	{
		shift = 10,
		mask = 3,
		[2] = {
			[0] = {
				[0] = {
					[0] = "strbDwO",
					"ldrbDwO",
					"ldrsbDxO",
					"ldrsbDwO",
					shift = 22,
					mask = 3
				},
				{
					[0] = "strhDwO",
					"ldrhDwO",
					"ldrshDxO",
					"ldrshDwO",
					shift = 22,
					mask = 3
				},
				{
					[0] = "strDwO",
					"ldrDwO",
					"ldrswDxO",
					shift = 22,
					mask = 3
				},
				{
					[0] = "strDxO",
					"ldrDxO",
					shift = 22,
					mask = 3
				},
				shift = 30,
				mask = 3
			},
			{
				shift = 30,
				mask = 3,
				[2] = {
					[0] = "strDsO",
					"ldrDsO",
					shift = 22,
					mask = 3
				},
				[3] = {
					[0] = "strDdO",
					"ldrDdO",
					shift = 22,
					mask = 3
				}
			},
			shift = 26,
			mask = 1
		}
	},
	shift = 21,
	mask = 1
}
local map_lsp = {
	[0] = {
		[0] = {
			[0] = "stpDzAzwP",
			"stpDzAzsP",
			shift = 26,
			mask = 1
		},
		{
			"stpDzAzdP",
			shift = 26,
			mask = 1
		},
		{
			[0] = "stpDzAzxP",
			shift = 26,
			mask = 1
		},
		shift = 30,
		mask = 3
	},
	{
		[0] = {
			[0] = "ldpDzAzwP",
			"ldpDzAzsP",
			shift = 26,
			mask = 1
		},
		{
			[0] = "ldpswDAxP",
			"ldpDzAzdP",
			shift = 26,
			mask = 1
		},
		{
			[0] = "ldpDzAzxP",
			shift = 26,
			mask = 1
		},
		shift = 30,
		mask = 3
	},
	shift = 22,
	mask = 1
}
local map_ls = {
	shift = 24,
	mask = 49,
	[16] = map_lrl,
	[48] = map_lsriro,
	[32] = {
		map_lsp,
		map_lsp,
		map_lsp,
		shift = 23,
		mask = 3
	},
	[33] = {
		map_lsp,
		map_lsp,
		map_lsp,
		shift = 23,
		mask = 3
	},
	[49] = {
		[0] = {
			[0] = {
				[0] = "strbDwzU",
				"ldrbDwzU",
				shift = 22,
				mask = 3
			},
			{
				[0] = "strhDwzU",
				"ldrhDwzU",
				shift = 22,
				mask = 3
			},
			{
				[0] = "strDwzU",
				"ldrDwzU",
				shift = 22,
				mask = 3
			},
			{
				[0] = "strDxzU",
				"ldrDxzU",
				shift = 22,
				mask = 3
			},
			shift = 30,
			mask = 3
		},
		{
			shift = 30,
			mask = 3,
			[2] = {
				[0] = "strDszU",
				"ldrDszU",
				shift = 22,
				mask = 3
			},
			[3] = {
				[0] = "strDdzU",
				"ldrDdzU",
				shift = 22,
				mask = 3
			}
		},
		shift = 26,
		mask = 1
	}
}
local map_datafp = {
	{
		[0] = {
			{
				[0] = {
					[0] = {
						[0] = {
							[0] = {
								shift = 15,
								mask = 1,
								[0] = {
									[0] = {
										[57] = "fcvtzuDwNs",
										[121] = "fcvtzuDwNd",
										[104] = "fcvtpsDwNd",
										[112] = "fcvtmsDwNd",
										[99] = "ucvtfDdNw",
										[97] = "fcvtnuDwNd",
										[100] = "fcvtasDwNd",
										[33] = "fcvtnuDwNs",
										[39] = "fmovDsNw",
										[35] = "ucvtfDsNw",
										[105] = "fcvtpuDwNd",
										[96] = "fcvtnsDwNd",
										[113] = "fcvtmuDwNd",
										[120] = "fcvtzsDwNd",
										[32] = "fcvtnsDwNs",
										[38] = "fmovDwNs",
										[36] = "fcvtasDwNs",
										[40] = "fcvtpsDwNs",
										mask = 255,
										[48] = "fcvtmsDwNs",
										[101] = "fcvtauDwNd",
										[56] = "fcvtzsDwNs",
										[37] = "fcvtauDwNs",
										[98] = "scvtfDdNw",
										[41] = "fcvtpuDwNs",
										[49] = "fcvtmuDwNs",
										shift = 16,
										[34] = "scvtfDsNw"
									},
									{
										[96] = "fcvtnsDxNd",
										[121] = "fcvtzuDxNd",
										[104] = "fcvtpsDxNd",
										[112] = "fcvtmsDxNd",
										[100] = "fcvtasDxNd",
										[97] = "fcvtnuDxNd",
										[56] = "fcvtzsDxNs",
										[33] = "fcvtnuDxNs",
										[105] = "fcvtpuDxNd",
										[102] = "fmovDxNd",
										[99] = "ucvtfDdNx",
										[113] = "fcvtmuDxNd",
										[120] = "fcvtzsDxNd",
										[103] = "fmovDdNx",
										[32] = "fcvtnsDxNs",
										[57] = "fcvtzuDxNs",
										[36] = "fcvtasDxNs",
										[40] = "fcvtpsDxNs",
										mask = 255,
										[48] = "fcvtmsDxNs",
										[101] = "fcvtauDxNd",
										[35] = "ucvtfDsNx",
										[37] = "fcvtauDxNs",
										[98] = "scvtfDdNx",
										[41] = "fcvtpuDxNs",
										[49] = "fcvtmuDxNs",
										shift = 16,
										[34] = "scvtfDsNx"
									},
									shift = 31,
									mask = 1
								}
							},
							{
								shift = 31,
								mask = 1,
								[0] = {
									[0] = {
										[0] = "fmovDNf",
										"fabsDNf",
										"fnegDNf",
										"fsqrtDNf",
										false,
										"fcvtDdNs",
										false,
										false,
										"frintnDNf",
										"frintpDNf",
										"frintmDNf",
										"frintzDNf",
										"frintaDNf",
										false,
										"frintxDNf",
										"frintiDNf",
										shift = 15,
										mask = 63
									},
									{
										[0] = "fmovDNf",
										"fabsDNf",
										"fnegDNf",
										"fsqrtDNf",
										"fcvtDsNd",
										false,
										false,
										false,
										"frintnDNf",
										"frintpDNf",
										"frintmDNf",
										"frintzDNf",
										"frintaDNf",
										false,
										"frintxDNf",
										"frintiDNf",
										shift = 15,
										mask = 63
									},
									shift = 22,
									mask = 3
								}
							},
							shift = 14,
							mask = 1
						},
						{
							shift = 31,
							mask = 1,
							[0] = {
								shift = 14,
								mask = 3,
								[0] = {
									shift = 23,
									mask = 1,
									[0] = {
										[0] = "fcmpNMf",
										[24] = "fcmpeNZf",
										[8] = "fcmpNZf",
										[16] = "fcmpeNMf",
										mask = 31,
										shift = 0
									}
								}
							}
						},
						shift = 13,
						mask = 1
					},
					{
						shift = 31,
						mask = 1,
						[0] = {
							shift = 5,
							mask = 31,
							[0] = {
								[0] = "fmovDFf",
								shift = 23,
								mask = 1
							}
						}
					},
					shift = 12,
					mask = 1
				},
				{
					shift = 31,
					mask = 1,
					[0] = {
						shift = 23,
						mask = 1,
						[0] = {
							[0] = "fccmpNMVCf",
							"fccmpeNMVCf",
							shift = 4,
							mask = 1
						}
					}
				},
				{
					shift = 31,
					mask = 1,
					[0] = {
						shift = 23,
						mask = 1,
						[0] = {
							[0] = "fmulDNMf",
							"fdivDNMf",
							"faddDNMf",
							"fsubDNMf",
							"fmaxDNMf",
							"fminDNMf",
							"fmaxnmDNMf",
							"fminnmDNMf",
							"fnmulDNMf",
							shift = 12,
							mask = 15
						}
					}
				},
				{
					shift = 31,
					mask = 1,
					[0] = {
						[0] = "fcselDNMCf",
						shift = 23,
						mask = 1
					}
				},
				shift = 10,
				mask = 3
			},
			shift = 21,
			mask = 1
		},
		{
			shift = 31,
			mask = 1,
			[0] = {
				[0] = {
					[0] = "fmaddDNMAf",
					"fnmaddDNMAf",
					shift = 21,
					mask = 5
				},
				{
					[0] = "fmsubDNMAf",
					"fnmsubDNMAf",
					shift = 21,
					mask = 5
				},
				shift = 15,
				mask = 1
			}
		},
		shift = 24,
		mask = 1
	},
	shift = 28,
	mask = 7
}
local map_br = {
	[0] = "bB",
	{
		[0] = "cbzDBg",
		"cbnzDBg",
		"tbzDTBw",
		"tbnzDTBw",
		shift = 24,
		mask = 3
	},
	{
		shift = 24,
		mask = 3,
		[0] = {
			shift = 4,
			mask = 1,
			[0] = {
				[0] = "beqB",
				"bneB",
				"bhsB",
				"bloB",
				"bmiB",
				"bplB",
				"bvsB",
				"bvcB",
				"bhiB",
				"blsB",
				"bgeB",
				"bltB",
				"bgtB",
				"bleB",
				"balB",
				shift = 0,
				mask = 15
			}
		}
	},
	false,
	"blB",
	{
		[0] = "cbzDBg",
		"cbnzDBg",
		"tbzDTBx",
		"tbnzDTBx",
		shift = 24,
		mask = 3
	},
	{
		[0] = {
			[2097152] = "brkW",
			shift = 0,
			mask = 14680095
		},
		{
			[204831] = "nop",
			shift = 0,
			mask = 4194303
		},
		{
			[6225920] = "retNx",
			[4128768] = "blrNx",
			mask = 16776223,
			[2031616] = "brNx",
			shift = 0
		},
		shift = 24,
		mask = 3
	},
	shift = 29,
	mask = 7
}
local map_init = {
	[0] = false,
	false,
	false,
	false,
	map_ls,
	map_datar,
	map_ls,
	map_datafp,
	map_datai,
	map_datai,
	map_br,
	map_br,
	map_ls,
	map_datar,
	map_ls,
	map_datafp,
	shift = 25,
	mask = 15
}
local map_regs = {
	x = {},
	w = {},
	d = {},
	s = {}
}

for i = 0, 30 do
	map_regs.x[i] = "x" .. i
	map_regs.w[i] = "w" .. i
	map_regs.d[i] = "d" .. i
	map_regs.s[i] = "s" .. i
end

map_regs.x[31] = "sp"
map_regs.w[31] = "wsp"
map_regs.d[31] = "d31"
map_regs.s[31] = "s31"

local map_cond = {
	[0] = "eq",
	"ne",
	"cs",
	"cc",
	"mi",
	"pl",
	"vs",
	"vc",
	"hi",
	"ls",
	"ge",
	"lt",
	"gt",
	"le",
	"al"
}
local map_shift = {
	[0] = "lsl",
	"lsr",
	"asr"
}
local map_extend = {
	[0] = "uxtb",
	"uxth",
	"uxtw",
	"uxtx",
	"sxtb",
	"sxth",
	"sxtw",
	"sxtx"
}

local function putop(ctx, text, operands)
	local pos = ctx.pos
	local extra = ""

	if ctx.rel then
		local sym = ctx.symtab[ctx.rel]

		if sym then
			extra = "\t->" .. sym
		end
	end

	if ctx.hexdump > 0 then
		ctx.out(format("%08x  %s  %-5s %s%s\n", ctx.addr + pos, tohex(ctx.op), text, concat(operands, ", "), extra))
	else
		ctx.out(format("%08x  %-5s %s%s\n", ctx.addr + pos, text, concat(operands, ", "), extra))
	end

	ctx.pos = pos + 4
end

local function unknown(ctx)
	return putop(ctx, ".long", {
		"0x" .. tohex(ctx.op)
	})
end

local function match_reg(p, pat, regnum)
	return map_regs[match(pat, p .. "%w-([xwds])")][regnum]
end

local function fmt_hex32(x)
	if x < 0 then
		return tohex(x)
	else
		return format("%x", x)
	end
end

local imm13_rep = {
	1431655765,
	286331153,
	16843009,
	65537,
	1
}

local function decode_imm13(op)
	local imms = band(rshift(op, 10), 63)
	local immr = band(rshift(op, 16), 63)

	if band(op, 4194304) == 0 then
		local len = 5

		if imms >= 56 then
			len = imms >= 60 and 1 or 2
		elseif imms >= 48 then
			len = 3
		elseif imms >= 32 then
			len = 4
		end

		local l = lshift(1, len) - 1
		local s = band(imms, l)
		local r = band(immr, l)
		local imm = ror(rshift(-1, 31 - s), r)

		if len ~= 5 then
			imm = band(imm, lshift(1, l) - 1) + rshift(imm, 31 - l)
		end

		imm = imm * imm13_rep[len]

		local ix = fmt_hex32(imm)

		if rshift(op, 31) ~= 0 then
			return ix .. tohex(imm)
		else
			return ix
		end
	else
		local lo, hi = -1, 0

		if imms < 32 then
			lo = rshift(-1, 31 - imms)
		else
			hi = rshift(-1, 63 - imms)
		end

		if immr ~= 0 then
			hi = ror(hi, immr)
			lo = ror(lo, immr)

			local x = immr == 32 and 0 or band(bxor(lo, hi), lshift(-1, 32 - immr))

			hi = bxor(hi, x)
			lo = bxor(lo, x)

			if immr >= 32 then
				hi = lo
				lo = hi
			end
		end

		if hi ~= 0 then
			return fmt_hex32(hi) .. tohex(lo)
		else
			return fmt_hex32(lo)
		end
	end
end

local function parse_immpc(op, name)
	if name == "b" or name == "bl" then
		return arshift(lshift(op, 6), 4)
	elseif name == "adr" or name == "adrp" then
		local immlo = band(rshift(op, 29), 3)
		local immhi = lshift(arshift(lshift(op, 8), 13), 2)

		return bor(immhi, immlo)
	elseif name == "tbz" or name == "tbnz" then
		return lshift(arshift(lshift(op, 13), 18), 2)
	else
		return lshift(arshift(lshift(op, 8), 13), 2)
	end
end

local function parse_fpimm8(op)
	local sign = band(op, 1048576) == 0 and 1 or -1
	local exp = bxor(rshift(arshift(lshift(op, 12), 5), 24), 128) - 131
	local frac = 16 + band(rshift(op, 13), 15)

	return sign * frac * 2^exp
end

local function prefer_bfx(sf, uns, imms, immr)
	if imms < immr or imms == 31 or imms == 63 then
		return false
	end

	if immr == 0 then
		if sf == 0 and (imms == 7 or imms == 15) then
			return false
		end

		if sf ~= 0 and uns == 0 and (imms == 7 or imms == 15 or imms == 31) then
			return false
		end
	end

	return true
end

local function disass_ins(ctx)
	local pos = ctx.pos
	local b0, b1, b2, b3 = byte(ctx.code, pos + 1, pos + 4)
	local op = bor(lshift(b3, 24), lshift(b2, 16), lshift(b1, 8), b0)
	local operands = {}
	local suffix = ""
	local last, name, pat, map_reg

	ctx.op = op
	ctx.rel = nil
	last = nil

	local opat = map_init[band(rshift(op, 25), 15)]

	while type(opat) ~= "string" do
		if not opat then
			return unknown(ctx)
		end

		opat = opat[band(rshift(op, opat.shift), opat.mask)] or opat._
	end

	name, pat = match(opat, "^([a-z0-9]*)(.*)")

	local altname, pat2 = match(pat, "|([a-z0-9_.|]*)(.*)")

	if altname then
		pat = pat2
	end

	if sub(pat, 1, 1) == "." then
		local s2, p2 = match(pat, "^([a-z0-9.]*)(.*)")

		suffix = suffix .. s2
		pat = p2
	end

	local rt = match(pat, "[gf]")

	if rt then
		map_reg = rt == "g" and (band(op, 2147483648) ~= 0 and map_regs.x or map_regs.w) or band(op, 4194304) ~= 0 and map_regs.d or map_regs.s
	end

	local second0, immr

	for p in gmatch(pat, ".") do
		local x

		if p == "D" then
			local regnum = band(op, 31)

			x = rt and map_reg[regnum] or match_reg(p, pat, regnum)
		elseif p == "N" then
			local regnum = band(rshift(op, 5), 31)

			x = rt and map_reg[regnum] or match_reg(p, pat, regnum)
		elseif p == "M" then
			local regnum = band(rshift(op, 16), 31)

			x = rt and map_reg[regnum] or match_reg(p, pat, regnum)
		elseif p == "A" then
			local regnum = band(rshift(op, 10), 31)

			x = rt and map_reg[regnum] or match_reg(p, pat, regnum)
		elseif p == "B" then
			local addr = ctx.addr + pos + parse_immpc(op, name)

			ctx.rel = addr
			x = "0x" .. tohex(addr)
		elseif p == "T" then
			x = bor(band(rshift(op, 26), 32), band(rshift(op, 19), 31))
		elseif p == "V" then
			x = band(op, 15)
		elseif p == "C" then
			x = map_cond[band(rshift(op, 12), 15)]
		elseif p == "c" then
			local rn = band(rshift(op, 5), 31)
			local rm = band(rshift(op, 16), 31)
			local cond = band(rshift(op, 12), 15)
			local invc = bxor(cond, 1)

			x = map_cond[cond]

			if altname and cond ~= 14 and cond ~= 15 then
				local a1, a2 = match(altname, "([^|]*)|(.*)")

				if rn == rm then
					local n = #operands

					operands[n] = nil
					x = map_cond[invc]

					if rn ~= 31 then
						name = a1 and a1 or altname
					else
						operands[n - 1] = nil
						name = a2
					end
				end
			end
		elseif p == "W" then
			x = band(rshift(op, 5), 65535)
		elseif p == "Y" then
			x = band(rshift(op, 5), 65535)

			local hw = band(rshift(op, 21), 3)

			if altname and (hw == 0 or x ~= 0) then
				name = altname
			end
		elseif p == "L" then
			local rn = map_regs.x[band(rshift(op, 5), 31)]
			local imm9 = arshift(lshift(op, 11), 23)

			x = band(op, 2048) ~= 0 and "[" .. rn .. ", #" .. imm9 .. "]!" or "[" .. rn .. "], #" .. imm9
		elseif p == "U" then
			local rn = map_regs.x[band(rshift(op, 5), 31)]
			local sz = band(rshift(op, 30), 3)
			local imm12 = lshift(arshift(lshift(op, 10), 20), sz)

			x = imm12 ~= 0 and "[" .. rn .. ", #" .. imm12 .. "]" or "[" .. rn .. "]"
		elseif p == "K" then
			local rn = map_regs.x[band(rshift(op, 5), 31)]
			local imm9 = arshift(lshift(op, 11), 23)

			x = imm9 ~= 0 and "[" .. rn .. ", #" .. imm9 .. "]" or "[" .. rn .. "]"
		elseif p == "O" then
			local rn, rm = map_regs.x[band(rshift(op, 5), 31)]
			local m = band(rshift(op, 13), 1)

			x = "[" .. rn .. ", " .. (m == 0 and map_regs.w[band(rshift(op, 16), 31)] or map_regs.x[band(rshift(op, 16), 31)])

			local opt = band(rshift(op, 13), 7)
			local s = band(rshift(op, 12), 1)
			local sz = band(rshift(op, 30), 3)

			x = opt == 3 and (s == 0 and x .. "]" or x .. ", lsl #" .. sz .. "]") or (opt == 2 or opt == 6 or opt == 7) and (s == 0 and x .. ", " .. map_extend[opt] .. "]" or x .. ", " .. map_extend[opt] .. " #" .. sz .. "]") or x .. "]"
		elseif p == "P" then
			local opcv, sh = rshift(op, 26), 2

			if opcv >= 42 then
				sh = 4
			elseif opcv >= 27 then
				sh = 3
			end

			local imm7 = lshift(arshift(lshift(op, 10), 25), sh)
			local rn = map_regs.x[band(rshift(op, 5), 31)]
			local ind = band(rshift(op, 23), 3)

			if ind == 1 then
				x = "[" .. rn .. "], #" .. imm7
			elseif ind == 2 then
				x = imm7 == 0 and "[" .. rn .. "]" or "[" .. rn .. ", #" .. imm7 .. "]"
			elseif ind == 3 then
				x = "[" .. rn .. ", #" .. imm7 .. "]!"
			end
		elseif p == "I" then
			local shf = band(rshift(op, 22), 3)
			local imm12 = band(rshift(op, 10), 4095)
			local rn, rd = band(rshift(op, 5), 31), band(op, 31)

			if altname == "mov" and shf == 0 and imm12 == 0 and (rn == 31 or rd == 31) then
				name = altname
				x = nil
			elseif shf == 0 then
				x = imm12
			elseif shf == 1 then
				x = imm12 .. ", lsl #12"
			end
		elseif p == "i" then
			x = "#0x" .. decode_imm13(op)
		elseif p == "1" then
			immr = band(rshift(op, 16), 63)
			x = immr
		elseif p == "2" then
			x = band(rshift(op, 10), 63)

			if altname then
				local a1, a2, a3, a4, a5, a6 = match(altname, "([^|]*)|([^|]*)|([^|]*)|([^|]*)|([^|]*)|(.*)")
				local sf = band(rshift(op, 26), 32)
				local uns = band(rshift(op, 30), 1)

				if prefer_bfx(sf, uns, x, immr) then
					name = a2
					x = x - immr + 1
				elseif immr == 0 and x == 7 then
					local n = #operands

					operands[n] = nil

					if sf ~= 0 then
						operands[n - 1] = gsub(operands[n - 1], "x", "w")
					end

					last = operands[n - 1]
					name = a6
					x = nil
				elseif immr == 0 and x == 15 then
					local n = #operands

					operands[n] = nil

					if sf ~= 0 then
						operands[n - 1] = gsub(operands[n - 1], "x", "w")
					end

					last = operands[n - 1]
					name = a5
					x = nil
				elseif x == 31 or x == 63 then
					if x == 31 and immr == 0 and name == "sbfm" then
						name = a4

						local n = #operands

						operands[n] = nil

						if sf ~= 0 then
							operands[n - 1] = gsub(operands[n - 1], "x", "w")
						end

						last = operands[n - 1]
					else
						name = a3
					end

					x = nil
				elseif band(x, 31) ~= 31 and immr == x + 1 and name == "ubfm" then
					name = a4
					last = "#" .. sf + 32 - immr
					operands[#operands] = "#" .. sf + 32 - immr
					x = nil
				elseif x < immr then
					name = a1
					last = "#" .. sf + 32 - immr
					operands[#operands] = "#" .. sf + 32 - immr
					x = x + 1
				end
			end
		elseif p == "3" then
			x = band(rshift(op, 10), 63)

			if altname then
				local a1, a2 = match(altname, "([^|]*)|(.*)")

				if x < immr then
					name = a1

					local sf = band(rshift(op, 26), 32)

					last = "#" .. sf + 32 - immr
					operands[#operands] = "#" .. sf + 32 - immr
					x = x + 1
				elseif immr <= x then
					name = a2
					x = x - immr + 1
				end
			end
		elseif p == "4" then
			x = band(rshift(op, 10), 63)

			local rn = band(rshift(op, 5), 31)
			local rm = band(rshift(op, 16), 31)

			if altname and rn == rm then
				local n = #operands

				operands[n] = nil
				last = operands[n - 1]
				name = altname
			end
		elseif p == "5" then
			x = band(rshift(op, 16), 31)
		elseif p == "S" then
			x = band(rshift(op, 10), 63)

			if x == 0 then
				x = nil
			else
				x = map_shift[band(rshift(op, 22), 3)] .. " #" .. x
			end
		elseif p == "X" then
			local opt = band(rshift(op, 13), 7)

			if opt ~= 3 and opt ~= 7 then
				last = map_regs.w[band(rshift(op, 16), 31)]
				operands[#operands] = last
			end

			x = band(rshift(op, 10), 7)

			if opt == 2 + band(rshift(op, 31), 1) and band(rshift(op, second0 and 5 or 0), 31) == 31 then
				if x == 0 then
					x = nil
				else
					x = "lsl #" .. x
				end
			else
				x = x == 0 and map_extend[band(rshift(op, 13), 7)] or map_extend[band(rshift(op, 13), 7)] .. " #" .. x
			end
		elseif p == "R" then
			x = band(rshift(op, 21), 3)

			if x == 0 then
				x = nil
			else
				x = "lsl #" .. x * 16
			end
		elseif p == "z" then
			local n = #operands

			if operands[n] == "sp" then
				operands[n] = "xzr"
			elseif operands[n] == "wsp" then
				operands[n] = "wzr"
			end
		elseif p == "Z" then
			x = 0
		elseif p == "F" then
			x = parse_fpimm8(op)
		elseif p == "g" or p == "f" or p == "x" or p == "w" or p == "d" or p == "s" then
			-- block empty
		elseif p == "0" then
			if last == "sp" or last == "wsp" then
				local n = #operands

				operands[n] = nil
				last = operands[n - 1]

				if altname then
					local a1, a2 = match(altname, "([^|]*)|(.*)")

					if not a1 then
						name = altname
					elseif second0 then
						altname = a1
						name = a2
					else
						altname = a2
						name = a1
					end
				end
			end

			second0 = true
		else
			assert(false)
		end

		if x then
			last = x

			if type(x) == "number" then
				x = "#" .. x
			end

			operands[#operands + 1] = x
		end
	end

	return putop(ctx, name .. suffix, operands)
end

local function disass_block(ctx, ofs, len)
	ofs = ofs or 0

	if len then
		if not (ofs + len) then
			local stop = #ctx.code

			ctx.pos = ofs
			ctx.rel = nil

			while stop > ctx.pos do
				disass_ins(ctx)
			end
		end
	end
end

local function create(code, addr, out)
	local ctx = {}

	ctx.code = code
	ctx.addr = addr or 0
	ctx.out = out or io.write
	ctx.symtab = {}
	ctx.disass = disass_block
	ctx.hexdump = 8

	return ctx
end

local function disass(code, addr, out)
	create(code, addr, out):disass()
end

local function regname(r)
	if r < 32 then
		return map_regs.x[r]
	end

	return map_regs.d[r - 32]
end

return {
	create = create,
	disass = disass,
	regname = regname
}
