# youtube_id values below reference real YouTube videos as of research time; video availability may change.

songs = [
  { artist: "Tom Jobim", title: "Garota de Ipanema", youtube_id: "z4mNBMK5oK0", genre: "bossa_nova", difficulty: "easy", clip_start: 30 },
  { artist: "Tom Jobim", title: "Águas de Março", youtube_id: "gtpxwLuu3D8", genre: "bossa_nova", difficulty: "medium", clip_start: 20 },
  { artist: "Caetano Veloso", title: "Sozinho", youtube_id: "E8NH2f1Nbpk", genre: "mpb", difficulty: "medium", clip_start: 15 },
  { artist: "Caetano Veloso", title: "Alegria, Alegria", youtube_id: "he_ghOAXbSM", genre: "mpb", difficulty: "hard", clip_start: 10 },
  { artist: "Gilberto Gil", title: "Aquele Abraço", youtube_id: "hUotcHXeeWA", genre: "mpb", difficulty: "easy", clip_start: 5 },
  { artist: "Chico Buarque", title: "Construção", youtube_id: "wBfVsucRe1w", genre: "mpb", difficulty: "hard", clip_start: 40 },
  { artist: "Chico Buarque", title: "A Banda", youtube_id: "mdm6Lys9Agg", genre: "mpb", difficulty: "medium", clip_start: 10 },
  { artist: "Elis Regina", title: "Como Nossos Pais", youtube_id: "gdgj1kYqiFI", genre: "mpb", difficulty: "medium", clip_start: 15 },
  { artist: "Tim Maia", title: "Não Vou Ficar", youtube_id: "wkk_XOI2pMY", genre: "soul_samba", difficulty: "easy", clip_start: 10 },
  { artist: "Legião Urbana", title: "Tempo Perdido", youtube_id: "qku-HL1pmYs", genre: "rock_nacional", difficulty: "easy", clip_start: 45 },
  { artist: "Marisa Monte", title: "Ainda Bem", youtube_id: "Pmt01TGsGGA", genre: "mpb", difficulty: "medium", clip_start: 20 },
  { artist: "Gal Costa", title: "Baby", youtube_id: "lqNYi0r35Rg", genre: "mpb", difficulty: "hard", clip_start: 15 },
  { artist: "Djavan", title: "Flor de Lis", youtube_id: "A0ueq_sTy00", genre: "mpb", difficulty: "medium", clip_start: 20 },
  { artist: "Cazuza", title: "Exagerado", youtube_id: "szts-5Zs5_8", genre: "rock_nacional", difficulty: "easy", clip_start: 15 },
  { artist: "Rita Lee", title: "Ovelha Negra", youtube_id: "zbd_ObeUoZI", genre: "rock_nacional", difficulty: "medium", clip_start: 20 },
  { artist: "Novos Baianos", title: "Preta Pretinha", youtube_id: "awMgzlojvLw", genre: "samba", difficulty: "hard", clip_start: 10 },
  { artist: "Seu Jorge", title: "Carolina", youtube_id: "095s4Sox-9E", genre: "soul_samba", difficulty: "easy", clip_start: 30 },
  { artist: "Jorge Ben Jor", title: "Mas Que Nada", youtube_id: "oCM_VWzSiMo", genre: "samba", difficulty: "easy", clip_start: 5 },
  { artist: "Daniela Mercury", title: "Música de Rua", youtube_id: "exmVnOvpqp4", genre: "axe", difficulty: "easy", clip_start: 20 }
]

songs.each do |attrs|
  song = Song.find_or_initialize_by(artist: attrs[:artist], title: attrs[:title])
  song.youtube_id = attrs[:youtube_id]
  song.genre = attrs[:genre]
  song.clip_start = attrs[:clip_start]
  song.clip_end = attrs[:clip_start] + 15
  song.difficulty = attrs[:difficulty]
  song.save!
end

puts "Seeded #{Song.count} songs."
