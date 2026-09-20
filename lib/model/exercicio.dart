class Exercicio {

  // Atributos

  int? _id;
  String _nome;
  String _grupoMuscular;
  int _series;
  int _repeticoes;
  int _duracao;
  String _nivel;


  // Construtor para quando o BD ainda não definiu o id.

  Exercicio(
      this._nome,
      this._grupoMuscular,
      this._series,
      this._repeticoes,
      this._duracao,
      this._nivel,
      );


  // Construtor para quando já tivermos o id.

  Exercicio.withId(
      this._id,
      this._nome,
      this._grupoMuscular,
      this._series,
      this._repeticoes,
      this._duracao,
      this._nivel,
      );


  // Getters...

  int? get id => _id;

  String get nome => _nome;

  String get grupoMuscular => _grupoMuscular;

  int get series => _series;

  int get repeticoes => _repeticoes;

  int get duracao => _duracao;

  String get nivel => _nivel;


  // Setters...

  set nome(String novoNome) {
    if (novoNome.length <= 255) {
      _nome = novoNome;
    }
  }

  set grupoMuscular(String novoGrupoMuscular) {
    if (novoGrupoMuscular.length <= 255) {
      _grupoMuscular = novoGrupoMuscular;
    }
  }

  set series(int novasSeries) {
    if (novasSeries > 0) {
      _series = novasSeries;
    }
  }

  set repeticoes(int novasRepeticoes) {
    if (novasRepeticoes > 0) {
      _repeticoes = novasRepeticoes;
    }
  }

  set duracao(int novaDuracao) {
    if (novaDuracao >= 0) {
      _duracao = novaDuracao;
    }
  }

  set nivel(String novoNivel) {
    _nivel = novoNivel;
  }


  // Converte o objeto para Map.
  // Será utilizado pelo SQLite.

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();

    map["nome"] = _nome;
    map["grupoMuscular"] = _grupoMuscular;
    map["series"] = _series;
    map["repeticoes"] = _repeticoes;
    map["duracao"] = _duracao;
    map["nivel"] = _nivel;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }


  // Cria um objeto Exercicio a partir de um Map.
  // Será utilizado quando os dados vierem do SQLite.

  Exercicio.fromMap(Map<String, dynamic> o)
      :
        _id = o["id"],
        _nome = o["nome"],
        _grupoMuscular = o["grupoMuscular"],
        _series = o["series"],
        _repeticoes = o["repeticoes"],
        _duracao = o["duracao"],
        _nivel = o["nivel"];
}