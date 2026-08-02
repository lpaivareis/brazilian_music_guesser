# NOTE: youtube_id values below are placeholders and must be verified/replaced with real YouTube video IDs before production use.

songs = [
  { artist: "Tom Jobim", title: "Garota de Ipanema", youtube_id: "aB1cD2eF3gH", difficulty: "easy" },
  { artist: "Tom Jobim", title: "Águas de Março", youtube_id: "bC2dE3fG4hI", difficulty: "medium" },
  { artist: "Caetano Veloso", title: "Sozinho", youtube_id: "cD3eF4gH5iJ", difficulty: "medium" },
  { artist: "Caetano Veloso", title: "Alfomega", youtube_id: "dE4fG5hI6jK", difficulty: "hard" },
  { artist: "Gilberto Gil", title: "Aquele Abraço", youtube_id: "eF5gH6iJ7kL", difficulty: "easy" },
  { artist: "Chico Buarque", title: "Construção", youtube_id: "fG6hI7jK8lM", difficulty: "hard" },
  { artist: "Chico Buarque", title: "A Banda", youtube_id: "gH7iJ8kL9mN", difficulty: "medium" },
  { artist: "Elis Regina", title: "Como Nossos Pais", youtube_id: "hI8jK9lM0nO", difficulty: "medium" },
  { artist: "Tim Maia", title: "Não Vou Ficar", youtube_id: "iJ9kL0mN1oP", difficulty: "easy" },
  { artist: "Legião Urbana", title: "Tempo Perdido", youtube_id: "jK0lM1nO2pQ", difficulty: "easy" },
  { artist: "Marisa Monte", title: "Ainda Bem", youtube_id: "kL1mN2oP3qR", difficulty: "medium" },
  { artist: "Gal Costa", title: "Baby", youtube_id: "lM2nO3pQ4rS", difficulty: "hard" },
  { artist: "Djavan", title: "Flor de Lis", youtube_id: "mN3oP4qR5sT", difficulty: "medium" },
  { artist: "Cazuza", title: "Exagerado", youtube_id: "nO4pQ5rS6tU", difficulty: "easy" },
  { artist: "Rita Lee", title: "Ovelha Negra", youtube_id: "oP5qR6sT7uV", difficulty: "medium" },
  { artist: "Novos Baianos", title: "Preta Pretinha", youtube_id: "pQ6rS7tU8vW", difficulty: "hard" },
  { artist: "Seu Jorge", title: "Carolina", youtube_id: "qR7sT8uV9wX", difficulty: "easy" },
  { artist: "Jorge Ben Jor", title: "Mas Que Nada", youtube_id: "rS8tU9vW0xY", difficulty: "easy" },
]

songs.each do |attrs|
  Song.find_or_create_by!(artist: attrs[:artist], title: attrs[:title]) do |s|
    s.youtube_id = attrs[:youtube_id]
    s.clip_start = 30
    s.clip_end = 45
    s.difficulty = attrs[:difficulty]
  end
end

puts "Seeded #{Song.count} songs."
